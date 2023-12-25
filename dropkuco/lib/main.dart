import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _items = [
    'Kekerasan',
    'Pelecehan',
    'Bulliying',
    'Sampah',
    'Pungli',
    'Infrastruktur',
    'Umum',
    'Pelayanan',
    'Keamanan',
  ];
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo', style: TextStyle(color: Colors.red)),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItem = '';
                    });
                  },
                  child: PopupMenuButton<String>(
                    
                    itemBuilder: (BuildContext context) {
                      return _items.map((String item) {
                        return PopupMenuItem(
                          value: item,
                          child: Container(width:  MediaQuery.of(context).size.width - 0, child: Text(item, style: TextStyle(color: Colors.red))),
                        );
                      }).toList();
                    },
                    onSelected: (String item) {
                      setState(() {
                        _selectedItem = item;
                      });
                    },
                    child: Icon(Icons.grid_view, color: Colors.red),
                  ),
                ),
                SizedBox(width: 20),
                AnimatedSwitcher(
                  
                  duration: Duration(milliseconds: 250),
                  child: _selectedItem.isEmpty
                      ? Text('Text terpilih', style: TextStyle(color: Colors.red))
                      : Text(
                          _selectedItem,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
