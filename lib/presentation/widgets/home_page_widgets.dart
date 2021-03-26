import 'package:flutter/material.dart';
import 'package:flutter_unleashed/presentation/pages/design_page.dart';
import 'package:flutter_unleashed/presentation/pages/dictionary_page.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';
import 'package:flutter_unleashed/presentation/pages/response_page.dart';

const appbarTitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 19,
    color: Colors.white);

Widget getCurrentAppBarTitle(Widget currentPage) {
  Widget currentAppBarText;
  switch (currentPage.runtimeType) {
    case InfoPage:
      currentAppBarText = Text('Info', style: appbarTitleStyle);
      break;
    case DesignPage:
      currentAppBarText = Text('Design', style: appbarTitleStyle);
      break;
    case ResponsePage:
      currentAppBarText = Text('Response', style: appbarTitleStyle);
      break;
    case DictionaryPage:
      currentAppBarText = Text('Dictionary', style: appbarTitleStyle);
      break;
    default:
      currentAppBarText = Text('');
  }

  return currentAppBarText;
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    Key key,
    this.index,
    this.children,
    this.duration = const Duration(
      milliseconds: 500,
    ),
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
      _scaleController.forward(from: 0.92);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();

    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        value: 0.92,
        lowerBound: 0.92,
        upperBound: 1);
    _scaleAnimation =
        CurvedAnimation(parent: _scaleController, curve: Curves.easeOut);

    _scaleController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: IndexedStack(
          index: widget.index,
          children: widget.children,
        ),
      ),
    );
  }
}
