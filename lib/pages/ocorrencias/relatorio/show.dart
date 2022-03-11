import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowRelatorio extends StatefulWidget {
  const ShowRelatorio({Key? key}) : super(key: key);

  @override
  Show_RelatorioState createState() => Show_RelatorioState();
}

class Show_RelatorioState extends State<ShowRelatorio> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  String relatorioUrl = Get.arguments;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Relatório'),
      ),
      body: SfPdfViewer.network(relatorioUrl,
          key: _pdfViewerKey,
          canShowScrollHead: false,
          canShowScrollStatus: false,
          canShowPaginationDialog: false),
    );
  }
}
