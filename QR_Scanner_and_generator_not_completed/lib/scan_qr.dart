import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrResult='scanned data will apper here';
  Future<void> ScanQR()async{
    try{

      final qrCode=await FlutterBarcodeScanner.scanBarcode('ff666666', 'Cancel', true, ScanMode.QR);
      if(!mounted)return;
      setState(() {
        
        this.qrResult=qrCode.toString();
      });
    }on PlatformException{
      qrResult= 'failed to read QR code';
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qr Code Scanner')),
      body:  Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('$qrResult', style: TextStyle(color: Colors.black)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed:  ScanQR, child: Text('Scan Code'))
          ],
        ),
      ),
    );
  }
}
