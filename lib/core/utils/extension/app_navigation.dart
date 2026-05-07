import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> pushPage<T>(Widget page, {void Function(T? result)? then}) {
    return Navigator.of(
      this,
    ).push<T>(MaterialPageRoute(builder: (context) => page)).then((result) {
      if (then != null) {
        then(result);
      }
      return result;
    });
  }

  void pushPageFade(Widget page, {Function()? then}) {
    Navigator.of(this).push(_createFadeRoute(page));
  }

  void pushReplacementPage(Widget page, {Function()? then}) {
    Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (context) => page)).then((_) {
      if (then != null) {
        then();
      }
    });
  }

  void pushFadeReplacementPage(Widget page, {Function()? then}) {
    Navigator.of(this).pushReplacement(_createFadeRoute(page));
  }

  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 800), // Fade speed
    );
  }

  void pushAndRemoveUntilPage(Widget page, {Function()? then}) {
    Navigator.of(this)
        .pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page),
          (route) => false,
        )
        .then((_) {
          if (then != null) {
            then();
          }
        });
  }

  void popUntilPage() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void popUntilPageOfType<T extends Widget>() {
    Navigator.of(this).popUntil((route) {
      return route.settings is MaterialPageRoute &&
          (route.settings as MaterialPageRoute).builder(this) is T;
    });
  }

  // void popPage<T>([T? result]) {
  //   Navigator.of(this).pop(result);
  // }
  void popPage<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
