import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/login_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';

class IntroView extends StatefulWidget
{
  IntroView({Key? key}) : super(key: key);

  static const routeName = '/intro';


  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView>
{
  LocalStorage _localStorage = LocalStorage.getInstance();
  bool _enabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IntroView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print( this._localStorage.getToken() );

    if ( this._localStorage.getToken().isEmpty ) {
      setState(() {
        this._enabled = true;
      });
    }
  }


  @override
  Widget build(BuildContext context)
  {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Image(
                      alignment: Alignment(0, 0),
                      image: AssetImage(
                        "assets/images/bg_intro.png",
                      ),
                      width: widthOfScreen,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TituloPrimario("Ukubiku"),
                          TextoDescricao(
                            "Ache Lugares Incríveis para se manter hospedado durante as suas férias em diversas cidades",
                            TextAlign.center,
                            margin: EdgeInsets.symmetric(vertical: 40),
                          ),
                          PrimaryButton("Começar", (){
                              print("Começar");
                              Navigator.restorablePushNamed(context, LoginPage.routeName);
                            },
                            disabled: !this._enabled,
                          )
                        ],
                      )
                  )

                ]
            ) ,
          ),
        )
    );
  }
}


