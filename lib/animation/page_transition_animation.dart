import 'package:flutter/cupertino.dart';

class AnimatedPageTransition extends PageRouteBuilder {
  final Widget widget;

  AnimatedPageTransition({this.widget})
      : super(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.center,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animate,
                Animation<double> secondAnimation) {
              return widget;
            });
}
