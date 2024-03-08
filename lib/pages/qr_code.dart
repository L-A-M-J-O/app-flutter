import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/qr_image.dart';
import 'package:flutter_application_1/pages/qr_scaner.dart';
import 'package:flutter_application_1/pages/qr_sunmi.dart';

class QRCode extends StatefulWidget {
  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Enter you URL'),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QRImage(controller: controller)));
            },
            child: const Text('Generate QR Code')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRScaner()));
            },
            child: const Text('Scan QR Code')),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const QRSunmi()));
        },  child: const Text('Sunmi'))
      ]),
    );
  }
}
