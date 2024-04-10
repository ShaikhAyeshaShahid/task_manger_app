import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/router.dart';
import '../../constants/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(
      const Duration(seconds: 3),
      /*() => Navigator.of(context).push(
        MaterialPageRoute(
          // builder: (BuildContext context) => const SignInScreen(),
          builder: (BuildContext context) => const SignUpScreen(),
        ),
      // ),*/
          () => Navigator.of(context)
          .pushReplacementNamed(AppRoutes.signinScreenRoute),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
        const BoxDecoration(gradient: GlobalColors.backgroundGradient),
        child: Center(
          child: Hero(
            tag: 'donation_logo',
            child: Image.asset(
              'assets/images/splash_logo.png',
              width: SizeConfig.width(context, 0.35),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
