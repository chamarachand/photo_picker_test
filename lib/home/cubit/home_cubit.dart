import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:photo_picker_test/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // List<File> _images = [];

  HomeCubit() : super(HomeInitial());

  Future<void> addImage(File image) async {
    emit(ImageSelected(image: image));
  }

  Future<void> removeImage(File image) async {
    emit(ImageRemoved(image: image));
  }

  Future<void> isLoading() async {
    emit(ImageLoading(loading: true));
  }

  Future<void> isLoaded() async {
    emit(ImageLoaded(loaded: true));
  }

  Future<void> saveAsPdf(List<File> imageFiles) async {
    if (imageFiles.isEmpty) return;

    // Create PDF
    final pdf = pw.Document();
    for (File file in imageFiles) {
      final imageBytes = await file.readAsBytes();
      final pdfImage = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(pdfImage));
          },
        ),
      );
    }

    debugPrint("Pdf created");

    // Save PDF to file
    final outputDir = await getTemporaryDirectory();
    final pdfFile = File("${outputDir.path}/output.pdf");
    await pdfFile.writeAsBytes(await pdf.save());

    debugPrint("Pdf saved");

    // Send PDF to backend

    // Open the PDF file after saving
    await OpenFile.open(pdfFile.path);
  }
}
