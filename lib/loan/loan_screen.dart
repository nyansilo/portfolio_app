import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:portfolio/data/model/project_list_model.dart';

import '../resources/strings.dart';

class LoanScreen extends StatefulWidget {
  static const routeName = '/loan';

  final ProjectList projectlist;

  LoanScreen({Key key, @required this.projectlist}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dependantController = TextEditingController();
  TextEditingController appIncomeController = TextEditingController();
  TextEditingController coAppIncomeController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanAmTermController = TextEditingController();
  TextEditingController creditHistController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController marriedController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController selfEmpController = TextEditingController();
  TextEditingController propAreaController = TextEditingController();

  String _apiMessage = '';
  bool _isUploading = false;
  bool _isSending = false;

  bool _loadingProgress = false;
  double _progressValue = 0.0;

  void _savePlace() async {
    print('save called');
/*

    if (firstNameController.text.isEmpty) {
      return;
    }

   setState(() {
      _isSending = true;
      //_isUploading = true;
      _loadingProgress = !_loadingProgress;
      _updateProgress();
    });

    //print("Text name: $name");

    // *********** USING DIO PACKAGE *********

    Dio dio = new Dio();
    FormData formData = new FormData(); // just like JS

    formData.add("Firstname", firstNameController.text);
    formData.add("Lastname", lastNameController.text);
    formData.add("Dependents", dependantController.text);
    formData.add("ApplicantIncome", appIncomeController.text);
    formData.add("CoapplicantIncome", coAppIncomeController.text);
    formData.add("LoanAmountt", loanAmountController.text);
    formData.add("Loan_Amount_Term", loanAmTermController.text);
    formData.add("Credit_History", creditHistController.text);
    formData.add("Gender", genderController.text);
    formData.add("Married", marriedController.text);
    formData.add("Education", educationController.text);
    formData.add("Self_Employed", selfEmpController.text);
    formData.add("Property_Area", propAreaController.text);

    var url = 'http://10.0.2.2:8000/api/loan/';
    //var token = await _getMobileToken();
    Map<String, String> headers = {
      //'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data",
      "X-Requested-With": "XMLHttpRequest"
    };

    Response response = await dio.post(url, data: formData,
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

        if (data["message"].contains('Status')) {
          _apiMessage = data["message"];
          print(_apiMessage);

        }



      });
    }).catchError(print);
*/

    //Pop up a dialog after fetching the results

    setState(() {
      _buildProgressBar(context);

      print('dialog2');
      return Builder(
        builder: (context) {
          print('dialog3');
          return _ackAlert(context);
        },
      );


    });

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

  /////////////// Progress bar ///////////
  Widget _buildProgressBar(context) {
    print('prb');
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
    } else if (_apiMessage != null && !_loadingProgress) {
      btnWidget = Container(
        child: Text(
          _apiMessage.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return btnWidget;
  }

/////////////// show dialog ///////////
  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(
        msg.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (x) => dialog);
    print('dialog called');
  }

  _ackAlert(BuildContext context) async {
    print('dialog mm');

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  /////////////// Main Widget ///////////

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.projectlist.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 4.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /////////////// first Name////////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                controller: firstNameController,
                                cursorColor: Color(0xFF9b9b9b),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.grey,
                                  ),
                                  hintText: firstName,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// lastName////////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.description,
                                  ),
                                  hintText: lastName,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// dependent////////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: dependantController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: dependent,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// applicantIncome///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: appIncomeController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: applicantIncome,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// coApplicantIncome///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: coAppIncomeController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: coApplicantIncome,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////  loanAmount///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: loanAmountController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: loanAmount,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////  loanAmountTerm///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: loanAmTermController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: loanAmountTerm,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////  creditHistory///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: creditHistController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: creditHistory,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// gender ///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: genderController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: gender,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// married ///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: marriedController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: married,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// education ///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: educationController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: education,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// selfEmployed, ///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: selfEmpController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: selfEmployed,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              ///////////// propertyArea ///////////
                              TextField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                controller: propAreaController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  hintText: propertyArea,
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////// SignUp Button ////////////

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isSending ? 'Sending...' : 'Send',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  //onPressed:  _isSending  ? null : _savePlace,
                                  /*onPressed: () {
                                    _savePlace();
                                    _showDialog(
                                      context,
                                      title: 'Hello',
                                      msg: _apiMessage,
                                    );
                                  },*/

                                  onPressed: _savePlace,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.0,),
                      //_buildProgressBar(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
