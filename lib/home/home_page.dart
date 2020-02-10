//main import

import 'package:flutter/material.dart';

//bloc and pages imports
import '../home/home_index.dart';

//resources import

import '../utils/app_localizations.dart';
import '../resources/strings.dart';

//universal import
import '../universal/conf_scaffold.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return ConfScaffold(
      title: home_appbar_title,
      //title: AppLocalizations.of(context).translate(home_appbar_title),
      body: HomeScreen(
        homeBloc: _homeBloc,
      ),
    );
  }
}
