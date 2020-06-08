import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import 'download_dialog.dart';

enum DownloadTaskStatus {
  STARTING,
  DOWNLOADING,
  DONE,
  FAILED,
}

class DownloadService extends ChangeNotifier {
  int percent = 0;
  DownloadTaskStatus status = DownloadTaskStatus.STARTING;
  File downloadedFile;
  String folderName = 'My HTTP Folder';		// Change to suit the task at hand

  Future<void> downloadFile({
    @required BuildContext context,
    @required String url,
    @required String filename,
    String fileExtension = ".pdf",
    bool openAfterDownload = true,
  }) async {
    // Reset the vars from previous task.
    int downloaded = 0;
    status = DownloadTaskStatus.STARTING;
    percent = 0;
    downloadedFile = null;

    showDownloadProgressDialog(context);

    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    // This will only work on Android.
    // Use path_provider when platform is iOS.
    Directory directory = Directory("/storage/emulated/0/$folderName");

    List<List<int>> chunks = new List();

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Stream has started emitting
        // Download task has began
        status = DownloadTaskStatus.DOWNLOADING;

        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
        percent = (downloaded / r.contentLength * 100).ceil();

        notifyListeners();
      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');
        directory.createSync();

        // Save the file
        File file = new File('${directory.path}/$filename$fileExtension');
        final Uint8List bytes = Uint8List(r.contentLength);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }

        try {
          await file.writeAsBytes(bytes);
        } on FileSystemException catch (e) {
          status = DownloadTaskStatus.FAILED;
          notifyListeners();
          print(e.message);
          return;
        }

        // Set status to done
        status = DownloadTaskStatus.DONE;
        downloadedFile = file;

        notifyListeners();

        if (openAfterDownload) {
          Future.delayed(Duration(milliseconds: 500), () async {
            // Dismiss the dialog
            Navigator.pop(context);
            // Open the file
            await OpenFile.open(downloadedFile.path);
          });
        }
      });
    });
  }

  Future<bool> checkPermission() async {
    var status = await Permission.storage.status;

    if (status.isUndetermined || status.isDenied) {
      // Don't have permission yet
      if (await Permission.storage.shouldShowRequestRationale) {
        return await Permission.storage.request().isGranted;
      } else {
        return await Permission.storage.request().isGranted;
      }
    } else {
      return status.isGranted;
    }
  }
}
