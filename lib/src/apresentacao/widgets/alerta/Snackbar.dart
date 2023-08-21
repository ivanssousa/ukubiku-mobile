import 'package:flutter/material.dart';
import 'package:ukubiku/src/utils/cores.dart';

class SnackBarPrimaria
{
  String message    = "";
  Function onPress  = () {};
  BuildContext context;

  SnackBarPrimaria({required this.message, required this.onPress, required this.context});

  void show() {
    var snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Cores.primaria(),
      content: Container(
        child: Text(
          this.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
      action: SnackBarAction(
        label: 'Fechar',
        textColor: Colors.white,
        onPressed: () {
          this.onPress();
        },
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackbar);
  }
}

class SnackBarSecundaria
{
  String message    = "";
  Function onPress  = () {};
  BuildContext context;

  SnackBarSecundaria( this.message, this.onPress, this.context );

  show() {
    var snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Cores.secundaria(),
      content: Container(
        child: Text(
          this.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
      action: SnackBarAction(
        label: 'Fechar',
        textColor: Colors.white,
        onPressed: () {
          this.onPress();
        },
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackbar);
  }
}


class SnackBarErro
{
  String message    = "";
  Function onPress  = () {};
  BuildContext context;

  SnackBarErro( this.message, this.onPress, this.context );

  show() {
    var snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Cores.vermelha(),
      content: Container(
        child: Text(
          this.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
      action: SnackBarAction(
        label: 'Fechar',
        textColor: Colors.white,
        onPressed: () {
          this.onPress();
        },
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackbar);
  }
}


class SnackBarAlerta
{
  String message    = "";
  Function onPress  = () {};
  BuildContext context;

  SnackBarAlerta({required this.message, required this.onPress, required this.context});

  show() {
    var snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Cores.laranja(),
      content: Container(
        child: Text(
          this.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
      action: SnackBarAction(
        label: 'Fechar',
        textColor: Colors.white,
        onPressed: () {
          this.onPress();
        },
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackbar);
  }
}
