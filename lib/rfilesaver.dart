import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rfilesaver/enum/mime_type.dart';
import 'package:rfilesaver/model/saved_details.dart';

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
  ///
  /// [pathToSave] should be, ex: 'rfilesaver/receipts'
  /// don't add / (slash) at start and end.
  static Future<SavedDetails> saveFile({
    required Uint8List data,
    required String fileName,
    required String extension,
    required String mimeType,
    String? pathToSave,
  }) async {
    try {
      if (Platform.isAndroid) {
        if (!(await _checkStoragePermission())) {
          return Future.error('Permission not granted.');
        }
        String fileNameWithExtension = '$fileName.$extension';

        var path = await _methodChannel.invokeMethod(_chnlSvFile, {
          'data': data,
          'fileName': fileNameWithExtension,
          'mimeType': mimeType,
          'pathToSave': pathToSave,
        });

        SavedDetails sd = SavedDetails();
        sd.contentUri = path['contentUri'];
        sd.savedPath = path['savedPath'];
        return sd;
      }
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}${(pathToSave ?? "").trim().isNotEmpty ? '/$pathToSave' : ''}/$fileName.$extension';
        final file = File(filePath);
        if (!(await file.exists())) {
          await file.create(recursive: true);
        }
        await file.writeAsBytes(data);
        SavedDetails sd = SavedDetails();
        sd.savedPath = filePath;
        return sd;
      }
      throw UnimplementedError(
        'R File Saver is not availale for this platform ',
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrintStack(stackTrace: stackTrace, label: e.toString());
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
