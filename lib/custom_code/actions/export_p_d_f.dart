// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future exportPDF(StudentsRecord stdnDoc) async {
  // Add your function code here!

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Data Students'),
              pw.Divider(thickness: 2),
              pw.Text('Name : ' + stdnDoc.fullname),
              pw.Text('address : ' + stdnDoc.address),
            ],
          )));

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
