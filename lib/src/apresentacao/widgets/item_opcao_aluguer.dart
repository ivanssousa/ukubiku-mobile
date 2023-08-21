import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/item_selecionado_page.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemOpcaoAluguer extends StatelessWidget
{
  String    label    = "";
  Icon      prefixIcon = Icon( Icons.people_outline );
  Icon      sufixIcon  = Icon( Icons.people_outline );
  Function  _press  = () {};
  ItemOpcaoAluguer(this.label, this.prefixIcon, this.sufixIcon, {Key? key, Function? press }) {
    if ( press != null )  this._press = press;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: this.prefixIcon
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 40,
                    top: 8,
                  ),
                  child: Text(
                    this.label,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 300,
                    top: 7,
                  ),
                  child: this.sufixIcon
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          this._press();
        },
      ),
    );
  }
}
