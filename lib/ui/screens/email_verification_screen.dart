import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/screens/pin_verification_screen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';

import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/utility/app_constans.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  bool _emailVerificationInProcess = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text('Your Email Address',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                      'A 6 digit verification pin will be sent your email address ',
                      style: Theme.of(context).textTheme.titleSmall),
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
                      if (value!.trim().isEmpty) {
                        return 'Enter your email address';
                      }
                      if (AppConstans.emailRegExp.hasMatch(value) == false) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Visibility(
                    visible: _emailVerificationInProcess == false,
                    replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _onTapPinVerificationButton();
                          debugPrint('ok');
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Center(
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
                              children: const [
                                TextSpan(
                                  style: TextStyle(
                                    color: AppColors.themeColor,
                                  ),
                                  text: "Sign Up",
                                ),
                              ],
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapSignInPage),
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

  void _onTapSignInPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }

  /* void _onTapConfirmButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PinVerificationScreen(),
      ),
    );
  } */

  @override
  void dispose() {
    _emailTEController.dispose();

    super.dispose();
  }

  Future<void> _onTapPinVerificationButton() async {
    _emailVerificationInProcess = true;
    if (mounted) setState(() {});
    String userEmail = _emailTEController!.text.trim();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoveryEmail(userEmail));
    _emailVerificationInProcess = false;
    if (mounted) setState(() {});
    if (response.inSuccess) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerificationScreen(
              userEmail: userEmail,
            ),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage.toString() ?? 'Failled, please try again');
      }
    }
  }
}
