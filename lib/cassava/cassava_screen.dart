import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:portfolio/data/model/project_list_model.dart';
import 'package:portfolio/utils/api_util.dart';

import '../cassava/cassava_widgets/image_input.dart';

class CassavaScreen extends StatefulWidget {
  static const routeName = '/cassava';

  final ProjectList projectlist;

  CassavaScreen({Key key, @required this.projectlist}) : super(key: key);

  @override
  _CassavaScreenState createState() => _CassavaScreenState();
}

class _CassavaScreenState extends State<CassavaScreen> {
  final _nameController = TextEditingController();
  File _pickedImage;
  String _apiMessage = '';
  bool _isUploading = false;
  bool  _isSending = false;

  bool _loadingProgress = false;
  double _progressValue = 0.0;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
    setState(() {
      _apiMessage = '';
    });

  }

  void _savePlace() async {


    if (_nameController.text.isEmpty || _pickedImage == null) {
      return;
    }

    setState(() {
      _isSending = true;
      //_isUploading = true;
      _loadingProgress = !_loadingProgress;
      _updateProgress();
    });




    String name = _nameController.text;



    // Get base file name
    String fileName = basename(_pickedImage.path);
    print("Text name: $name");
    print("File base name: $fileName");



    // *********** USING DIO PACKAGE *********

    Dio dio = new Dio();
    FormData formData = new FormData(); // just like JS

    formData.add("name", _nameController.text);
    formData.add("imagefile", new UploadFileInfo(_pickedImage, fileName));

    /*

      FormData formData2 = FormData.from({
      'name': _nameController.text,
      'image':  new UploadFileInfo(_pickedImage, fileName),
    });

    */

    var cassavatUrl = ApiUtil.MAIN_API_URL + ApiUtil.CASSAVA;
    //var token = await _getMobileToken();
    Map<String, String> headers = {
      //'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data",
      "X-Requested-With": "XMLHttpRequest"
    };

    Response response = await dio.post(cassavatUrl, data: formData,
        onSendProgress: (int sent, int total) {
          if (sent != null) {
            setState(() {
              print(sent);
              _buildProgressBar(context);
            });
          }
        },
        options: Options(
            method: 'POST',
            headers: headers,
            responseType: ResponseType.json // or ResponseType.JSON
        )).then((r) {
      //print(r);

      setState(() {
        var data = json.decode(r.toString());
        print(data);

        if (data["message"].contains('prediction')) {
          _apiMessage = data["message"];
          print(_apiMessage);

          //warningAlert("Attendance Saved", "Your attendance saved Successfully",context);
        }
      });
    }).catchError(print);

    // *******USING MULTI PART REQUEST METHOD********** ////

    /*  var request = http.MultipartRequest("POST", Uri.parse("http://10.0.2.2:8000/api/dogcat/"));
    //add text fields
    request.fields["name"] = _nameController.text;
    //create multipart using filepath, string or bytes
    var imagefile = await http.MultipartFile.fromPath("imagefile", _pickedImage.path);
    //add multipart to request
    request.files.add(imagefile);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);*/


    setState(() {
      //_isUploading = true;
      _loadingProgress = false;
      _isSending = false;

    });
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loadingProgress = false;
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }

  Widget _buildProgressBar(context) {
    Widget btnWidget = Container();
    //double doubleVar = total.toDouble();
    if (_loadingProgress) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
        //margin: EdgeInsets.only(top: 10.0,left: 95.0, right: 95.0 ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            lineHeight: 20.0,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.black12,
            progressColor: Colors.orangeAccent,
            percent: _progressValue,
            center: Text('${(_progressValue * 100).round()}%'),
            animation: true,

          ),
        ),
      );
    } else if (_apiMessage != null && !_loadingProgress && _pickedImage != null) {
      btnWidget = Container(
        child: Text(
          _apiMessage.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return btnWidget;
  }

  Widget _buildUploadBtn() {
    Widget btnWidget = Container();
    if (_isUploading) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    } else if (!_isUploading && _pickedImage != null) {
      // If image is picked by the user then show a upload btn
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Upload'),
          onPressed: _savePlace,
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    }
    return btnWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.projectlist.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green),
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
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: _nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),

                    _buildProgressBar(context),

                    // _buildUploadBtn(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton.icon(
            icon:  _isSending  ? Icon(null) : Icon(Icons.add, color: Colors.white),
            label: Text(
              _isSending ? 'Sending...' : 'SEND DATA',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            //Disable button on sending data
            onPressed:  _isSending  ? null : _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color:  Colors.green,
          ),
        ],
      ),
    );
  }
}
