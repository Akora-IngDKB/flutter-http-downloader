import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'download_service.dart';

class DownloadPage extends StatelessWidget {
  final url = "http://www.pdf995.com/samples/pdf.pdf";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter HTTP Downloader'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.green,
          child: Text('Download File'),
          onPressed: () async {
            final provider =
                Provider.of<DownloadService>(context, listen: false);

            if (await provider.checkPermission()) {
              provider.downloadFile(
                context: context,
                url: url,
                filename: "A Simple PDF",
              );
            }
          },
        ),
      ),
    );
  }
}
