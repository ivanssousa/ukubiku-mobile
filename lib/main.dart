import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AuthController.dart';
import 'package:ukubiku/src/settings/sqlite/SQLiteStorage.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());


  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final navigationController = NavigationController();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  LocalStorage localStorage = LocalStorage.getInstance();

  await localStorage.loadSettings();

  await SQLLiteStorage.ensureDatabaseInitialization();

  try
  {
    print( localStorage.getToken() );
    User user = await AuthController().user();
    RouteSettings(name: RootUserPage.routeName);
  }
  catch ( ex ) {
    print( ex.toString() );
  }

  runApp(MyApp(
    settingsController: settingsController,
    navigationController:  navigationController
  ));
}
