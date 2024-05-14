import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SubmitView extends StatefulWidget {
  @override
  _SubmitViewState createState() => _SubmitViewState();
}

class _SubmitViewState extends State<SubmitView> {
  late MobileScannerController controller;
  late StreamSubscription<Barcode> barcodeSubscription;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    controller.start();

    // Listen to the barcodes stream and handle the scanned data.
    StreamSubscription<BarcodeCapture> barcodeSubscription =
        controller.barcodes.listen((barcode) {
      // Handle the scanned data here.
      // Make sure to access a property that exists on BarcodeCapture.
      print('Scanned barcode: ${barcode.raw}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MobileScanner(controller: controller),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
          Positioned(
            top: 60.0,
            left: 40.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    barcodeSubscription.cancel();
    super.dispose();
  }
}
