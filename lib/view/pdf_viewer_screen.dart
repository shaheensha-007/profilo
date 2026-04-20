import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerScreen extends StatefulWidget {
  final String assetPath;
  const PdfViewerScreen({super.key, required this.assetPath});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  void _downloadFile() async {
    // Navigates directly to the raw PDF asset in the browser, allowing the user to use the browser's download functionality!
    final Uri url = Uri.parse('assets/assets/mohammed_shaheen_pk.pdf');
    if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mohammed Shaheen PK - CV'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Download PDF',
            onPressed: () => _downloadFile(),
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      // SfPdfViewer natively supports Web, Windows, Android, and iOS!
      // This reads the PDF directly from the assets folder.
      body: SfPdfViewer.asset(
        widget.assetPath,
        key: _pdfViewerKey,
        canShowScrollHead: false,
        canShowScrollStatus: false,
      ),
    );
  }
}
