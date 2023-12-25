import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FormDataModel {
  String textValue;
  String selectedOption;
  String imagePath;

  FormDataModel({required this.textValue, required this.selectedOption, required this.imagePath});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormExample(),
    );
  }
}

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormDataModel _formData = FormDataModel(textValue: "", selectedOption: "", imagePath: "");

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Simpan nilai yang diisi ke dalam _formData

      try {
        Dio dio = Dio();
        FormData formData = FormData.fromMap({
          'textValue': _formData.textValue,
          'selectedOption': _formData.selectedOption,
          'image': await MultipartFile.fromFile(_formData.imagePath),
        });

        // Ganti URL sesuai kebutuhan
        Response response = await dio.post('https://example.com/api/post', data: formData);

        print(response.data);
        // Handle response dari server
      } catch (e) {
        print("Error: $e");
        // Handle error koneksi atau error lainnya
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Text Value'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Text value tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData.textValue = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _formData.selectedOption,
                onChanged: (value) {
                  setState(() {
                    _formData.selectedOption = value!;
                  });
                },
                items: ['Option 1', 'Option 2', 'Option 3'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Pilih Option'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Tambahkan logika untuk pemilihan gambar atau video
                  // Simpan path file media ke _formData.imagePath

                  // Contoh menggunakan package image_picker
                  // Pilih gambar dari galeri
                  // var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  // if (image != null) {
                  //   setState(() {
                  //     _formData.imagePath = image.path;
                  //   });
                  // }
                },
                child: Text('Pilih Gambar/Video'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Post Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
