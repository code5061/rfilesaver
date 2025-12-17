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
              child: pw.Text('Sample pdf created by J_File_Saver Plugin'),
            ),
          );
        },
      ),
    );

    return await pdf.save();
  }
}
