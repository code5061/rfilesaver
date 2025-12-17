import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rfilesaver/enum/mime_type.dart';

class Rfilesaver {
  static final MethodChannel _methodChannel = const MethodChannel('rfilesaver');
  static final String _chnlSvFile = "saveFile";

  ///[data] your data to save
  ///
  ///[fileName] name of your file without extension
  ///
  ///[mimeType] mimeType of your file. [MimeType.jpeg.mime]
  ///[extension] ex: .pdf .jpg
  /// you can take this from enum [MimeType.jpeg.extension]
  static Future<String?> saveFile({
    required Uint8List data,
    required String fileName,
    required String extension,
    required String mimeType,
  }) async {
    try {
      if (Platform.isAndroid) {
        if (!(await _checkStoragePermission())) {
          return Future.error('Permission not granted.');
        }
        String? path = await _methodChannel.invokeMethod(_chnlSvFile, {
          'data': data,
          'fileName': '$fileName.$extension',
          'mimeType': mimeType,
        });
        return path;
      }
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName.$extension';
        final file = File(filePath);
        await file.writeAsBytes(data);
        return filePath;
      }
      throw UnimplementedError(
        'R File Saver is not availale for this platform ',
      );
    } catch (e, s) {
      if (kDebugMode) {
        debugPrintStack(stackTrace: s, label: e.toString());
      }
      return Future.error('Unable to save file');
    }
  }

  static Future<bool> _checkStoragePermission() async {
    DeviceInfoPlugin dip = DeviceInfoPlugin();
    AndroidDeviceInfo adi = await dip.androidInfo;
    if (adi.version.sdkInt < 28) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
