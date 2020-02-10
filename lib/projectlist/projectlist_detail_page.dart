import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/cassava/cassava_screen.dart';
import 'package:portfolio/dogcat/dogcat_screen.dart';
import 'package:portfolio/loan/loan_screen.dart';
import 'package:portfolio/resources/app_settings.dart';
import 'package:portfolio/universal/conf_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/tools.dart';
import 'package:portfolio/data/model/project_list_model.dart';

class ProjectDetailPage extends StatelessWidget {
  static const String routeName = "/project-detail";

  final ProjectList projectlist;

  ProjectDetailPage({Key key, @required this.projectlist}) : super(key: key);

  Widget _buildUploadBtn(BuildContext context) {
    Widget btnWidget = Container();
    if (projectlist.url == null) {
      btnWidget = Container();
    } else {
      //implementation of TValue to work with switch
      TValue case2<TOptionType, TValue>(
        TOptionType selectedOption,
        Map<TOptionType, TValue> branches, [
        TValue defaultValue = null,
      ]) {
        if (!branches.containsKey(selectedOption)) {
          return defaultValue;
        }

        return branches[selectedOption];
      }

      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('PREDICTION'),
          //weird switch implementation
          onPressed: case2(
              projectlist.url,
              {
                //CASE 1:url for cassava
                AppSettings.CASSAVA_MAIN: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CassavaScreen(projectlist: projectlist),
                    ),
                  );
                },

                //CASE 2:url for loan
                AppSettings.LOAN_MAIN: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoanScreen(projectlist: projectlist),
                    ),
                  );
                },

                //CASE 3:url for dogcat
                AppSettings.DOGCAT_MAIN: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DogCatScreen(projectlist: projectlist),
                    ),
                  );
                },
              },
              () {}),

          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );

      /*btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Upload'),
          onPressed:(){},
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );*/
    }
    return btnWidget;
  }

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return ConfScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: projectlist.image,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: CachedNetworkImageProvider(
                      projectlist.image,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${projectlist.name}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${projectlist.technology}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                       fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Tools.multiColors[Random().nextInt(4)],
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                projectlist.description,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontFamily: 'Roboto',fontSize: 13),

              ),
              SizedBox(
                height: 20,
              ),
              _buildUploadBtn(context),
            ],
          ),
        ),
      ),
      title: projectlist.name,
    );
  }
}
