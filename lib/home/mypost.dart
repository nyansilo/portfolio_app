import 'package:flutter/material.dart';
import 'package:portfolio/resources/app_settings.dart';
import 'package:portfolio/resources/assets.dart';
import 'dart:io';
import 'dart:convert' show json, base64;


import 'post.dart';


class PostPage extends StatelessWidget {

  //static const String routeName ="/post";
  final Future<Post> post;

  PostPage({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = 'http://10.0.2.2:8000/api/dogcat/';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: titleControler,
                  decoration: InputDecoration(
                      hintText: "title....", labelText: 'Post Title'),
                ),
                new TextField(
                  controller: bodyControler,
                  decoration: InputDecoration(
                      hintText: "body....", labelText: 'Post Body'),
                ),
                new RaisedButton(
                    onPressed:  _handleLogin ,

                  /*onPressed: () async {
                    Post newPost = new Post(

                        name: 'dany',
                        image:'https://cdn2.thecatapi.com/images/cvi.jpg',
                        //image: bodyControler.text
                        );

                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.name);
                    print(p.image);
                  },*/
                  child: const Text("Create"),
                )

                /*new RaisedButton(
                  onPressed: () async {
                    Post newPost = new Post(
                        userId: "123",
                        id: 0,
                        title: titleControler.text,
                        body: bodyControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.title);
                  },
                  child: const Text("Create"),
                )*/


              ],
            ),
          )),
    );
  }


  void _handleLogin() async {

    File imageFile = new File(AppSettings.banner_dark);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);


    var data = {

      'name' : 'dany',

      'image' :base64Image,

    };

    var res = await CallApi().postData(data, 'http://10.0.2.2:8000/api/dogcat/');
    var body = json.decode(res.body);

    print(body);
    /*if(body['success']){

      print(body);
    }
*/





  }
}
