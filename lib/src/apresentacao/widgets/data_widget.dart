import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../utils/cores.dart';

class DataWidget extends StatefulWidget {
  String _label;
  DataWidget( this._label, {Key? key}) : super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all( color: Cores.secundaria() ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only( bottom: 15),
        width: double.infinity,
        height: 55,
        child: TextButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>( EdgeInsets.only(left: 10) ),
          ),
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1940, 1, 1),
                maxTime: DateTime(new DateTime.now().year, 12, 31),
                onChanged: (date) {
                  print('change $date');
                },
                onConfirm: (date) {
                  setState(() {
                    this.widget._label = '${date.day}-${date.month}-${date.year}';
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.pt
            );
          },
          child: Text(
            this.widget._label,
            style: TextStyle(color: Cores.secundaria() ),
            textAlign: TextAlign.left,
          ),
        )
    );
  }
}

