import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:io';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PdfViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

  Future<String> _loadPdf(String path) async {
    // Load the PDF from assets
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();

    // Get the temporary directory of the app
    final directory = await getTemporaryDirectory();
    final tempPath = '${directory.path}/pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';

    // Write the bytes to a file in the temporary directory
    final file = File(tempPath);
    await file.writeAsBytes(bytes);

    return tempPath; // Return the file path of the saved PDF
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<String>(
        future: _loadPdf(pdfPath), // Load PDF and get the file path
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No PDF data found.'));
          }

          // Return the PDF view with the file path
          return PDFView(
            filePath: snapshot.data!, // Pass the saved file path
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onError: (error) {
              print(error.toString());
            },
            onRender: (pages) {
              print('PDF Loaded with $pages pages.');
            },
          );
        },
      ),
    );
  }
}
