import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tambahkan Lokasi'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Text('Kecamatan'),
              Divider(
                thickness: 2.0,
               
              ),
              ListTile(
                title: Text('Batam Kota'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Bengkong'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Bulang'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Galang'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Lubuk Baja'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Nongsa'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Sagulung'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Sei'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
              ListTile(
                title: Text('Sekupang'),
                onTap: () {
                  // Aksi yang diambil ketika ListTile ditekan
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
