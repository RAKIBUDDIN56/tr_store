import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store/widgets/text_widget.dart';
import '../config/routes/routes_location.dart';

class SplashScreen extends StatefulWidget {
  static SplashScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const SplashScreen();
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
    super.activate();
  }

  navigate() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      context.go(RouteLocation.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(text: "Welcome to TR Store"),
      ),
    );
  }
}
