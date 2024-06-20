import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<PdfTrueTypeFont> loadCustomFont(double size) async {
  final fontData = await rootBundle.load('assets/fonts/Roboto-Light.ttf');
  final buffer = fontData.buffer;
  return PdfTrueTypeFont(buffer.asUint8List(), size);
}

Future<PdfTrueTypeFont> loadCustomFontForTable(double size) async {
  final fontData = await rootBundle.load('assets/fonts/ARIAL.TTF');
  final buffer = fontData.buffer;
  return PdfTrueTypeFont(buffer.asUint8List(), size);
}
