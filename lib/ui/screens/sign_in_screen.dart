import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/logIn_model.dart';
import 'package:taskmanager/data/models/network_response.dart';

import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/controllers/auth_controlres.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/main_bottom_nav_screen.dart';
import 'package:taskmanager/ui/screens/sign_up_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/utility/app_constans.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/screens/email_verification_screen.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInApiInPrograss = false;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    obscureText: true,
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
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
                    visible: _signInApiInPrograss == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapNextScreen,
                      child: const Icon(Icons.arrow_circle_right),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordScreen,
                          child: const Text('Forgot Password'),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                            ),
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: const TextStyle(
                                  color: AppColors.themeColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignUpPage,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _signUP() async {
    _signInApiInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };

    final NetworkResponse networkResponse =
        await NetworkCaller.postRequest(Urls.login, body: requestData);
    _signInApiInPrograss = false;
    if (mounted) {
      setState(() {});
    }
    if (networkResponse.inSuccess) {
      LogInModel loginModel = LogInModel.fromJson(networkResponse.responseData);
      await AuthControler.saveUserAccessToken(loginModel.token!);
      await AuthControler.saveUserData(loginModel.userModel!);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            networkResponse.errorMessage ?? 'Invalied Email/Paassword');
      }
    }
  }

  void _onTapNextScreen() {
    if (_formKey.currentState!.validate()) {
      _signUP();
    }
  }

  void _onTapSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _onTapForgotPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
