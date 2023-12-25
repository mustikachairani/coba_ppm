import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageVideoPickerPage extends StatefulWidget {
  @override
  _ImageVideoPickerPageState createState() => _ImageVideoPickerPageState();
}

class _ImageVideoPickerPageState extends State<ImageVideoPickerPage> {
  final ImagePicker _picker = ImagePicker();
  String? _imageName;

  Future<void> _pickMedia(bool isVideo) async {
    final source = isVideo ? ImageSource.camera : ImageSource.gallery;

    final XFile? pickedFile = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(source: source);

    if (pickedFile == null) {
      setState(() {});
      print('Gak jadi milih file');
    } else {
      print('Lo berhasil milih file: ${pickedFile.path}');
      setState(() {
        _imageName = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Video Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageName != null)
              isVideo(_imageName!)
            else
              Text('No media selected'),
            ElevatedButton(
              onPressed: () {
                _pickMedia(false); // Image
              },
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickMedia(true); // Video
              },
              child: Text('Pick Video'),
            ),
          ],
        ),
      ),
    );
  }

  Widget isVideo(String mediaPath) {
    // You can customize this widget to display the selected media
    return Column(
      children: [
        isImage(mediaPath),
        Text('Video Path: $mediaPath'),
      ],
    );
  }

  Widget isImage(String imagePath) {
    // You can customize this widget to display the selected image
    return Image.file(
      imagePath as File,
      height: 100,
      width: 100,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageVideoPickerPage(),
  ));
}
