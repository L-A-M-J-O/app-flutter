import 'package:flutter/material.dart';
import 'package:sunmi_scanner/sunmi_scanner.dart';
import 'package:flutter_application_1/pages/qr_code.dart';

class QRSunmi extends StatefulWidget {
  const QRSunmi({super.key});

  @override
  State<QRSunmi> createState() => _QRSunmiState();
}

class _QRSunmiState extends State<QRSunmi> {
  String? scannedValue;

  void _setScannedValue(String value) {
    setState(() {
      scannedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    SunmiScanner.onBarcodeScanned().listen((event) {
      _setScannedValue(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QRCode()));
            },
            child: const Text('Regresar'),
          ),
          Center(
            child: (scannedValue != null) ? Text(
              scannedValue ?? "Suposicion de datos",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ) : const Text('No hay datos Scaneados')
          ),
        ],
      ),
    );
  }
}
