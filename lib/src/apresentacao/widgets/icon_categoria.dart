import 'package:flutter/material.dart';

class IconCategoria extends StatelessWidget {
  IconData iconData;
  String texto;
  Function onPress;

  IconCategoria({Key? key, required this.iconData, required this.texto, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onPress();
      },
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Icon(this.iconData, size: 30,),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: 80,
              alignment: Alignment.center,
              child: Text(
                this.texto,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
