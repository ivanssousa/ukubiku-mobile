import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ukubiku/src/utils/FileManager.dart';

class BarCodeManager
{
  String data;
  late Barcode barcode;
  File? fileCreated;

  BarCodeManager({required this.data}) {
    this.barcode = Barcode.fromType(BarcodeType.Code128);
  }

  Future<String?> gerarBarCode() async
  {
    try
    {
      Directory dirRoot = await FileManager.documentos();
      PermissionStatus status = await Permission.storage.request();

      print("Granted ${status.isGranted}");
      print("Denied ${status.isDenied}");
      print("Limited ${status.isLimited}");
      print("Permanently ${status.isPermanentlyDenied}");

      PermissionStatus permissionStatus = await Permission.storage.request();
      if (!permissionStatus.isGranted)
        await openAppSettings();

      if (status.isGranted)
      {
        final svg = this.barcode.toSvg(this.data, width: 200, height: 50);
        Directory dir = await Directory(dirRoot.path+"/ukubiku");
        if ( !dir.existsSync() ) {
          dir.create();
        }
        String file = dir.path+"/"+DateTime.now().microsecond.toString()+".svg";
        this.fileCreated = await new File(file).writeAsString(svg);
      }
    }
    on FileSystemException catch (ex) {
      throw ex;
    }
    on Exception catch (ex) {
      print( ex.toString() );
      throw ex;
    }
    return null;
  }
}
