import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ukubiku/src/apresentacao/pages/filtrar_page.dart';
import 'package:ukubiku/src/apresentacao/pages/intro_view.dart';
import 'package:ukubiku/src/apresentacao/pages/login_page.dart';
import 'package:ukubiku/src/apresentacao/pages/pagina_inicial_page.dart';
import 'package:ukubiku/src/apresentacao/pages/perfil_cliente_page.dart';
import 'package:ukubiku/src/apresentacao/pages/procurar_page.dart';
import 'package:ukubiku/src/apresentacao/pages/resultado_procura_page.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/pages/sign_up_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/modals/modal_verificar_codigo.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp(
      {Key? key,
      required this.settingsController,
      required this.navigationController})
      : super(key: key);

  final SettingsController settingsController;
  final NavigationController navigationController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          debugShowCheckedModeBanner: false,

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            brightness: Brightness.light,
            // Define the default font family.
            fontFamily: 'Roboto',
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case IntroView.routeName:
                    return IntroView();
                  case LoginPage.routeName:
                    return LoginPage(
                        navigationController: this.navigationController);
                  case SignUpPage.routeName:
                    return SignUpPage(
                        navigationController: this.navigationController);
                  case PerfilClientePage.routeName:
                    return PerfilClientePage();
                  case PaginaInicialPage.routeName:
                    return PaginaInicialPage(
                        navigationController: this.navigationController);
                  case RootUserPage.routeName:
                    return RootUserPage();
                  default:
                    return IntroView();
                }
              },
            );
          },
        );
      },
    );
  }
}
