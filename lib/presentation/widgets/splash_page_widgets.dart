import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage(
      {Key key,
      @required this.size,
      @required this.scaleX,
      @required this.scaleY,
      @required this.offsetY})
      : super(key: key);
  final Size size;
  final double scaleX;
  final double scaleY;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
      child: Transform.translate(
        offset: Offset(-(scaleX - 1) / 2 * size.width,
            -(scaleY - 1) / 2 * size.height + offsetY),
        child: Image.asset('assets/images/splashscreenbackground.png',
            fit: BoxFit.cover),
      ),
    );
  }
}

class AnimatedLogoAndText extends StatelessWidget {
  const AnimatedLogoAndText(
      {Key key,
      @required this.fadeAnimation,
      @required this.offsetAnimation,
      @required this.scaleAnimation,
      @required this.width})
      : super(key: key);

  final Animation<double> scaleAnimation;
  final Animation<Offset> offsetAnimation;
  final Animation<double> fadeAnimation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 75.0, bottom: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: scaleAnimation,
              child: Image.asset('assets/images/bear-logo.png',
                  width: width, height: width),
            ),
            FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: offsetAnimation,
                child: const Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    'Flutter\nUnleashed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.0,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
