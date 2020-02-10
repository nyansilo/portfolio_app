
import 'package:flutter/material.dart';
import '../utils/tools.dart';
import 'package:portfolio/data/model/project_list_model.dart';


class ProjectDetailPage extends StatelessWidget {
  final ProjectList projectlist;

  ProjectDetailPage({this.projectlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cricket"),
      ),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Hero(
            tag: projectlist.image,
            child: Image.network(projectlist.image),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              projectlist.image,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(dateFormatter(projectlist.created)),
          ),
          Text(projectlist.description),
        ],
      ),
    );
  }
}
