import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:portfolio/home/post.dart';
import 'package:portfolio/resources/app_settings.dart';

import '../dogcat/dogcat_widgets/image_input1.dart';

class DogCatScreen extends StatefulWidget {
  static const routeName = '/dog-cat';

  @override
  _DogCatScreenState createState() => _DogCatScreenState();
}

class _DogCatScreenState extends State<DogCatScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() async {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    // Get base file name
    String fileName = basename(_pickedImage.path);
    print("File base name: $fileName");

    try {
      //FormData formData = new FormData.from({"file": new UploadFileInfo(_pickedImage, fileName)});

      Dio dio = new Dio();
      FormData formData = new FormData(); // just like JS

      formData.add("image", new UploadFileInfo(_pickedImage, fileName));
      formData.add("name", _titleController.text);
      var url = 'http://10.0.2.2:8000/api/dogcat/';
      //var token = await _getMobileToken();
      Map<String, String> headers = {
        //'Authorization': 'Bearer $token',
        "Content-Type": "multipart/form-data",
        "X-Requested-With": "XMLHttpRequest"
      };

      Response response = await dio.post(url,
          data: formData,
          options: Options(
              method: 'POST',
              headers: headers,
              responseType: ResponseType.json // or ResponseType.JSON
              ));
      print(formData);
      //Response response =
      //await Dio().post("http://192.168.0.101/saveFile.php", data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
      print(response.data['message']);
    } catch (e) {
      if (e is DioError) {
        print(e.message);
      } else if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }

    /* catch (e) {
        print("Exception Caught: $e");
      }
     */

    /* var data = {

      'name' : _titleController.text,
      'image' :   _pickedImage != null ? 'data:image/png;base64,' +
          base64Encode(_pickedImage.readAsBytesSync()) : '',

    };

    var res = await CallApi().postData(data, 'http://10.0.2.2:8000/api/dogcat/');
    var body = json.decode(res.body);

    print(body);
    */

    /*if(body['success']){

      print(body);
    }
*/
    /* File imageFile = new File(_pickedImage);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);

    Post newPost = new Post(
        name: _titleController.text,
        image: 'https://vaya.in/recipes/wp-content/uploads/2018/02/Milk-Chocolate-1.jpg',
    );

    Post p = await  CallApi().createPost('http://10.0.2.2:8000/api/dogcat/', body: newPost.toMap());
    print(p.name);
    print(p.image);
*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
