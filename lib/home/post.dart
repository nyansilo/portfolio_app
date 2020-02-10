import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Post {
  final String name;
  final String image;

  Post({this.name, this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      image: json['image'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["image"] = image;


    return map;
  }
}



class CallApi {

  postData(data, apiUrl) async {
    return await http.post(
      apiUrl,
      body: jsonEncode(data),
        headers: _setHeaders(),



    );

  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };



  Future<Post> createPost(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(body);
      print(responseData);
      return Post.fromJson(json.decode(response.body));

    });
  }


}

/*

void addProduct(String name, String image) {
  final Map<String, dynamic> postData = {
    'name': name,
    'image': 'https://cdn2.thecatapi.com/images/cvi.jpg'
  };
  http
      .post('https://jsonplaceholder.typicode.com/posts',
          body: json.encode(postData))
      .then((http.Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
  });
}

class Post {
  final String name;
  final String image;

  Post({
    @required this.name,
    @required this.image,
  });
}
*/
