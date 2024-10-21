// ignore_for_file: must_be_immutable

import 'package:barcode_widget/barcode_widget.dart';
import 'package:fats_mobile_demo/constants.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BarcodeLabelScreen extends StatefulWidget {
  List<String> tagNumber;
  List<String> assetDescription;
  List<String> qrCode;

  BarcodeLabelScreen({
    Key? key,
    required this.tagNumber,
    required this.assetDescription,
    required this.qrCode,
  }) : super(key: key);

  @override
  State<BarcodeLabelScreen> createState() => _BarcodeLabelScreenState();
}

class _BarcodeLabelScreenState extends State<BarcodeLabelScreen> {
  void createPdf() async {
    final doc = pw.Document();
    final image = await imageFromAssetBundle("assets/nartec1.png");

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPdf(image);
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  List<pw.Widget> buildPdf(image) {
    return List<pw.Widget>.generate(widget.tagNumber.length, (index) {
      return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.SizedBox(
            height: 100,
            width: double.infinity,
            child: pw.Image(
              image,
              width: double.infinity,
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Expanded(flex: 1, child: pw.Text('')),
              pw.SizedBox(width: 20),
              pw.Expanded(
                flex: 2,
                child: pw.BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: widget.tagNumber[index],
                  drawText: false,
                  width: 200,
                  height: 50,
                ),
              ),
              pw.SizedBox(width: 20),
              pw.Expanded(
                flex: 1,
                child: pw.SizedBox(
                  height: 50,
                  width: 50,
                  child: pw.BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: widget.qrCode[index],
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            widget.assetDescription[index],
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 5),
          if (index < widget.tagNumber.length - 1)
            pw.Divider(
              color: PdfColors.black,
              thickness: 1,
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createPdf();
        },
        label: const Text('Print/Save'),
        icon: const Icon(Icons.print),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.tagNumber.length,
        itemBuilder: (context, index) {
          return Card(
            shadowColor: Constant.primaryColor,
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/nartec1.png",
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 1, child: Text('')),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: widget.tagNumber[index],
                        drawText: true,
                        width: 200,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: widget.qrCode[index],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  widget.assetDescription[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.tagNumber.clear();
    widget.assetDescription.clear();
    widget.qrCode.clear();
  }
}
