import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/ui/controllers/auth_controlres.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/main_bottom_nav_screen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    bool isUserLoggedIn = await AuthControler.checkAuthState();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isUserLoggedIn
              ? const MainBottomNavScreen()
              : const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset('AssetPaths.appLogoSvg', width: 140),
        ),
      ),
    );
  }
}
