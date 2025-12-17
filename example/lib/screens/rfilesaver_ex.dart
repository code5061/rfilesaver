import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:rfilesaver/enum/mime_type.dart';
import 'package:rfilesaver/rfilesaver.dart';
import 'package:rfilesaver_example/pdf/sample_pdf.dart';
import 'package:rfilesaver_example/ui_utils/ui_utils.dart';

class RfilesaverExView extends StatefulWidget {
  const RfilesaverExView({super.key});

  @override
  State<RfilesaverExView> createState() => _RfilesaverExViewState();
}

class _RfilesaverExViewState extends State<RfilesaverExView> {
  final ValueNotifier<String> notifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('RFileSaver')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: size.height * 0.02,
        children: [
          MaterialButton(
            minWidth: size.width * 0.5,
            onPressed: createPdf,
            child: Text('Save Sample File'),
          ),
          Center(
            child: ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, child) {
                return Text(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  void createPdf() async {
    try {
      notifier.value = 'Creating pdf';

      Uint8List data = await SamplePdf.createPdf();

      notifier.value = 'Saving pdf file';

      String? path = await Rfilesaver.saveFile(
        data: data,
        fileName: 'rfilesaver_sample',
        extension: MimeType.pdf.extension,
        mimeType: MimeType.pdf.mime,
      );

      SnackBarAction? action;
      String msg = 'PDF File Created';
      if ((path ?? "").trim().isNotEmpty) {
        action = SnackBarAction(
          label: 'Open',
          onPressed: () {
            OpenFilex.open(path!);
          },
        );
      } else {
        msg = 'Unble to create pdf';
      }

      showSnackBar(context, msg, action: action);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
