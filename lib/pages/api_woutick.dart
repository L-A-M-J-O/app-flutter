import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account {
  String access;
  String refresh;
  String user;
  Account(this.access, this.refresh, this.user);
}

class ApiStandard extends StatefulWidget {
  const ApiStandard({super.key});

  @override
  State<ApiStandard> createState() => _ApiStandard();
}

class _ApiStandard extends State<ApiStandard> {
  List<Map<String, dynamic>> venues = [];

  Future<String> fetchToken() async {
    const String url = "https://api-dev.woutick.com/back/v1/account/login/";
    final response = await http.post(Uri.parse(url),
        body: {'email': 'alan.naranjo@woutick.es', 'password': 'lamjo303030'});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      return jsonData["access"];
    } else {
      throw Exception("Fallo a la hora de pedir los datos");
    }
  }

  Future<void> makeRequestWithToken() async {
    final token = await fetchToken();

    const String nextUrl = "https://api-dev.woutick.com/back/v1/promoter/";
    final nextResponse = await http.get(Uri.parse(nextUrl), headers: {
      'Authorization': 'Bearer $token',
    });

    if (nextResponse.statusCode == 200) {
      String nextResponseBody = utf8.decode(nextResponse.bodyBytes);
      final jsonData = jsonDecode(nextResponseBody);
      venues = List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception("Fallo al hacer la siguiente petición");
    }
  }

  @override
  void initState() {
    super.initState();
    makeRequestWithToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: ListView.builder(
              itemCount: venues.length,
              itemBuilder: (context, index) {
                final venue = venues[index]['name'];
                return ListTile(
                  title: Text(venue),
                );
              }),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
