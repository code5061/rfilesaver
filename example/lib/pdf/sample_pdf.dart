import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SamplePdf {
  static Future<Uint8List> createPdf() async {
    final pw.Document pdf = pw.Document(pageMode: PdfPageMode.fullscreen);

    PdfPageFormat pageFormat = PdfPageFormat.a4;

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (context) {
          return pw.Container(
            width: pageFormat.width * 0.7,
            height: pageFormat.height * 0.7,
            child: pw.Center(
              child: pw.Text('''Sample pdf created by J_File_Saver Plugin
              \n\n# rfilesaver

Plugin to save file in ANDROID or IOS device

## Getting Started

## Minimal Sample

```dart
String? path = await Rfilesaver.saveFile(
        data: data,
        fileName: 'rfilesaver_sample',
        extension: MimeType.pdf.extension,
        mimeType: MimeTgit push -u origin main --force
ype.pdf.mime,
      );
```
The MimeType has some predefined file types and its extension

## Android Setup
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="28" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />


## Note
    * For android file will be stored in download folder
    * In Ios file will be stores in application documents directory

## Used Dependencies
    permission_handler
    path_provider
    device_info_plus

## Support
    For any quries or issues or suggestions 5061code@gmail.com '''),
            ),
          );
        },
      ),
    );

    return await pdf.save();
  }
}
