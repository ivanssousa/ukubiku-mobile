import 'package:flutter/material.dart';

class ImagemPerfil extends StatelessWidget {
  double height = 100;
  double width  = 100;
  Function onTap = () {};

  ImagemPerfil({Key? key, required this.width, required this.height, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onTap();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image(
          alignment: Alignment(0, 0),
          image: AssetImage(
            "assets/images/user.png",
          ),
          fit: BoxFit.fill,
          width: this.width,
          height: this.height,
        ),
      ),
    );
  }
}
