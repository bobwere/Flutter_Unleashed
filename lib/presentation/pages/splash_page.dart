import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:flutter_unleashed/presentation/widgets/splash_page_widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  CircularSplashController _circularSplashController;
  AnimationController _scaleController;
  AnimationController _slideController;
  AnimationController _fadeController;
  Animation<double> _scaleAnimation;
  Animation<Offset> _offsetAnimation;
  Animation<double> _fadeAnimation;

  Ticker _ticker;

  @override
  void initState() {
    //create ticker to run once per frame
    super.initState();
    _ticker = Ticker((d) {
      setState(() {});
    })
      ..start();

    //initialize circular splash controller
    _circularSplashController = CircularSplashController(
        duration: Duration(milliseconds: 450),
        color: flutterUnleashedTheme.primaryColor);

    //initialize scalecontroller
    _scaleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _slideController.forward();
          _fadeController.forward();
        }
      })
      ..forward();

    //initialize slideController
    _slideController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(Duration(seconds: 3));
          navigateToHomePage();
        }
      });

    //initialize fadeController
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    //app name slide in animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    ));

    //app name fade in animation
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    //logo scale out animation
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    _circularSplashController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2 - 40;
    var size = MediaQuery.of(context).size;
    var time = DateTime.now().millisecondsSinceEpoch / 2000;
    var scaleX = 1.2 + sin(time) * 0.05;
    var scaleY = 1.2 + cos(time) * 0.07;
    var offsetY = 20 + cos(time) * 0.20;
    return CircularSplash(
      controller: _circularSplashController,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            //  =========  Moving background image ==========
            BackgroundImage(
                size: size, scaleX: scaleX, scaleY: scaleY, offsetY: offsetY),

            // ========== Animated Logo and Animated app name  ================
            AnimatedLogoAndText(
                fadeAnimation: _fadeAnimation,
                offsetAnimation: _offsetAnimation,
                scaleAnimation: _scaleAnimation,
                width: width)
          ],
        ),
      ),
    );
  }

  void navigateToHomePage() {
    _circularSplashController.pushReplacementNamed(context, "/homepage");
  }
}
