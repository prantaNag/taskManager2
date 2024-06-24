import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/utility/app_constans.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _registrationInPrograss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text('Get Started With',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Email";
                      }
                      if (AppConstans.emailRegExp.hasMatch(value!) == false) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your First Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Last Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileTEController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Mobile Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    obscureText: _showPassword == false,
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showPassword == !_showPassword;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: Icon(_showPassword
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _registrationInPrograss == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _userResister();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  _backToSignInSection(),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _backToSignInSection() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              text: "Have an account ",
              children: [
                TextSpan(
                  text: "Sign In",
                  style: const TextStyle(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapBackToSignInScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _userResister() async {
    _registrationInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
      "photo": ""
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);
    _registrationInPrograss = false;
    if (response.inSuccess) {
      _clearTextField();
      if (mounted) {
        showSnackBarMessage(context, 'Registration Success');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Registration failed. Try again.');
      }
    }
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _passwordTEController.clear();
    _mobileTEController.clear();
  }

  void _onTapBackToSignInScreen() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
