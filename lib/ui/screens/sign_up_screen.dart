import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';

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
                Text('Get Started With',
                    style: Theme.of(context).textTheme.titleLarge),
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
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileTEController,
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
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
                _backToSignInSection(),
              ],
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
                    style: TextStyle(
                      color: AppColors.themeColor,
                    ),
                    text: "Sign In",
                  ),
                ],
                recognizer: TapGestureRecognizer()
                  ..onTap = _onTapBackToSignInScreen),
          ),
        ],
      ),
    );
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
