import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Icon',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Icon'),
        ),
        body: Center(
          child: Row(
            
            children: [
              Image.asset('assets/images/loc.png',
                width: 50,
                height: 35,
                alignment: Alignment.center,
                
              ),
              Text('Jungkook', style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
