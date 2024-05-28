import 'dart:typed_data';
<<<<<<< HEAD

=======
>>>>>>> cddf457 (hi)
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:turfnest_admin/qr_comp/acivation.dart';
import 'package:turfnest_admin/routes.dart';

<<<<<<< HEAD

=======
>>>>>>> cddf457 (hi)
class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  String? value;
  TextEditingController text = TextEditingController();
  MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return Scaffold(
     
=======
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      print('Barcode found! ${barcode.rawValue}');
    }
    if (image != null) {
      showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              setState(() {
                value = barcodes.first.rawValue;
                _scannerController.stop(); // Stop the scanner
                Routes.instance.push(studentlist(id: value!), context);
              });
            },
            child: AlertDialog(
              title: Text(
                barcodes.first.rawValue ?? "",
              ),
              content: Image(
                image: MemoryImage(image),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
>>>>>>> cddf457 (hi)
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
<<<<<<< HEAD
              child: hi(),
            ),
            
=======
              child: MobileScanner(
                controller: _scannerController,
                onDetect: _onDetect,
              ),
            ),
>>>>>>> cddf457 (hi)
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget hi() {
    return MobileScanner(
      controller: _scannerController,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        final Uint8List? image = capture.image;
        for (final barcode in barcodes) {
          print('Barcode found! ${barcode.rawValue}');
        }
        if (image != null) {
          showDialog(
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    value = barcodes.first.rawValue;
                    Routes.instance.push(studentlist(id: value!), context);
                  });
                 
                },
                child: AlertDialog(
                  title: Text(
                    barcodes.first.rawValue ?? "",
                  ),
                  content: Image(
                    image: MemoryImage(image),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
=======
>>>>>>> cddf457 (hi)
}
