import 'dart:math';

import 'package:flutter/material.dart';
import '../projectlist/data_science_screen.dart';
import '../projectlist/graphic_design_screen.dart';

import '../universal/conf_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/tools.dart';

class ProjectListPage extends StatefulWidget {

  static const String routeName = "/project-list";

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {


  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 2,
      child: ConfScaffold(
        title: "Projects",
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[Random().nextInt(4)],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text("Data Science"),
              icon: Icon(
                FontAwesomeIcons.cloud,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Graphics Design"),
              icon: Icon(
                FontAwesomeIcons.mobile,
                size: 12,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            DataScienceScreen(),
            GraphicDesignScreen(),
          ],
        ),
      ),
    );
  }
}

