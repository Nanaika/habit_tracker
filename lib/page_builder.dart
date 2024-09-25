import 'package:flutter/material.dart';

Route createRoute(Widget page) {
  return PageRouteBuilder(transitionsBuilder: (ctx, anim1, anim2, widget) {

    // final start = Offset(1.0, 0.0);
    // const end = Offset.zero;
    const curve = Curves.easeInOut;
    // final tween = Tween(begin: start, end: end).chain(CurveTween(curve: curve));
    //
    // final tweenFade = Tween(begin: start, end: end).chain(CurveTween(curve: curve));

    //
    //
    // final curvedAnim = CurvedAnimation(parent: anim1, curve: curve);


    final slideTween = Tween<Offset>(
        begin: const Offset(1.0, 0.0), end: Offset.zero
    ).chain(CurveTween(curve: curve));

    final fadeTween = Tween<double>(
        begin: 0.0, end: 1.0
    ).chain(CurveTween(curve: curve));

    final offsetAnim = anim1.drive(slideTween);
    final fadeAnim = anim1.drive(fadeTween);

    return SlideTransition(position: offsetAnim, child: FadeTransition(opacity: fadeAnim, child: widget,),);
  }, pageBuilder: (ctx, anim1, anim2) {
    return page;
  });
}