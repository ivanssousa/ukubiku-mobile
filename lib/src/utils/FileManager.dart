import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager
{

  static Future<Directory> documentos() async {
    return await getTemporaryDirectory();
  }

  static Future<Directory> temporarios() async {
    return await getTemporaryDirectory();
  }

}