import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_circle_right),
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
                            children: [
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
      )),
    );
  }

  void _onTapSignInPage() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();

    super.dispose();
  }
}
