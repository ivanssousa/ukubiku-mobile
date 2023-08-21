import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';

class NavigationController {
  static NavigationController getInstance() {
    return NavigationController();
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => page),
    );
  }

  void toBottomMenu(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => RootUserPage(keyItemSelected: route),
      ),
    );
  }

  void voltar(BuildContext context, String route) {
    Navigator.restorablePushNamed(context, route);
  }
}
