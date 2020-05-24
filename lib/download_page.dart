import 'package:flutter/material.dart';

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter HTTP Downloader'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          color: Colors.green,
          child: Text('Download File'),
        ),
      ),
    );
  }
}
