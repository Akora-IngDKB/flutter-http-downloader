import 'package:flutter/material.dart';
import 'package:http_downloader/download_page.dart';
import 'package:http_downloader/download_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DownloadService(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.green),
        home: DownloadPage(),
      ),
    ),
  );
}
