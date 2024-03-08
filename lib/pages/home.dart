import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic human;

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  final dio = Dio();

  void getHttp() async {
    final response = await dio.get('https://api-dev.woutick.com/back/v1/account/login/');
    setState(() {
      human = response.data['results'];
    });
  }

  late String nombreUsuario = 'Usuario';

  void cambiarNombreUsuario(String newNombre) {
    setState(() {
      nombreUsuario = newNombre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return appBar();
  }
  Scaffold appBar() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'woutick!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: 35,
              child: SvgPicture.asset(
                'assets/icons/human.svg',
                height: 20,
                width: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[Text('Welcome $nombreUsuario')],
            ),
            Column(
              children: <Widget>[Text('data')]
            ),
            Column(
              children: <Widget>[
                // Otros widgets aquí
                ElevatedButton(
                  onPressed: () {
                    // Acción que quieres realizar al presionar el botón
                    cambiarNombreUsuario('Woutick!');
                  },
                  child: Text('Datos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
