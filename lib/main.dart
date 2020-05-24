import 'package:flutter/material.dart';
import 'package:http_downloader/download_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: DownloadPage(),
    ),
  );
}
