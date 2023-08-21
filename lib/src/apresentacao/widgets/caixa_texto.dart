import 'package:flutter/material.dart';
import 'package:ukubiku/src/utils/cores.dart';

class CaixaTexto extends StatelessWidget {
  String label = '';
  String value = '';
  String _descricao = '';
  bool _isPassword = false;
  TextInputType _inputType = TextInputType.text;
  Function _getTexto = () {};
  Function _onTap = () {};

  String _mensagemErro = "";

  TextAlign _textAlign = TextAlign.left;
  double _fontSize = 16;
  int _textLimite = 200;

  double height = 80;
  bool _enabled = true;
  bool _readOnly = false;

  dynamic _prefixIcon;
  dynamic _sufixIcon;

  String _hintText = "";

  TextEditingController _controller = TextEditingController(text: "");

  CaixaTexto(this.label, this.value,
      {Key? key,
      String? descricao,
      bool? isPassword,
      Function? getTexto,
      Function? onTap,
      TextInputType? inputType,
      dynamic? validator,
      TextAlign? textAlign,
      double? fontSize,
      int? textLimite,
      bool? enabled,
      bool? readOnly,
      Icon? prefixIcon,
      Icon? sufixIcon,
      TextEditingController? controller,
      String? hintText}) {
    if (descricao != null) this._descricao = descricao;
    if (isPassword != null) this._isPassword = isPassword;
    if (getTexto != null) this._getTexto = getTexto;
    if (onTap != null) this._onTap = onTap;
    if (inputType != null) this._inputType = inputType;
    if (textAlign != null) this._textAlign = textAlign;
    if (fontSize != null) this._fontSize = fontSize;
    if (textLimite != null) this._textLimite = textLimite;
    if (enabled != null) this._enabled = enabled;
    if (readOnly != null) this._readOnly = readOnly;
    if (prefixIcon != null) this._prefixIcon = prefixIcon;
    if (sufixIcon != null) this._sufixIcon = sufixIcon;
    if (controller != null)
      this._controller = controller;
    else
      this._controller.text = this.value ;
    if (hintText != null) this._hintText = hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: this._controller,
            onChanged: (String text) {
              this._getTexto(text);
            },
            onTap: () {
              this._onTap();
            },
            style: TextStyle(
              fontSize: this._fontSize,
            ),
            obscureText: this._isPassword,
            keyboardType: this._inputType,
            cursorColor: Theme.of(context).backgroundColor,
            textAlign: this._textAlign,
            readOnly: this._readOnly,
            maxLength: this._textLimite,
            decoration: InputDecoration(
              prefixIcon: this._prefixIcon ?? this._prefixIcon,
              suffixIcon: this._sufixIcon ?? this._sufixIcon,
              labelText: this.label,
              labelStyle: TextStyle(
                color: Cores.secundaria(),
              ),
              helperText: this._descricao,
              hintText: this._hintText,
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Cores.secundaria(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
