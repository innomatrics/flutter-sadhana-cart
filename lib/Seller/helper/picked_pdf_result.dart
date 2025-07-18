// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:pdfx/pdfx.dart';

class PickedPdfResult {
  final File file;
  final PdfPageImage? thumbnail;
  PickedPdfResult({
    required this.file,
    this.thumbnail,
  });
}
