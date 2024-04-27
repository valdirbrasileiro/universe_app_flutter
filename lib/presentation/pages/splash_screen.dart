import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../presentation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  bool isNavigatingHome = false;

  @override
  void initState() {
    super.initState();
    animationController.forward().then((_) => _navigateToHome());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    isNavigatingHome = true;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            final tween = Tween(begin: 0.0, end: 1.0);
            final opacityAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Colors.black,
        child: Lottie.asset(
          "assets/universe.json",
          repeat: true,
          animate: true,
          reverse: false,
        ));
  }
}
