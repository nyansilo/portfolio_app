import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/projectlist/projectlist_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'article/article_bloc.dart';
import 'config/config_page.dart';
import 'data/repositories/article_repository.dart';
import 'data/repositories/projectlist_repository.dart';
import 'resources/app_settings.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  AppSettings.prefs = await SharedPreferences.getInstance();

  /*
  runApp(BlocProvider<ArticleBloc>(
    builder: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
    child: ConfigPage(),
  ));
  runApp(BlocProvider<ProjectListBloc>(
    builder: (context) =>
        ProjectListBloc(projectListRepository: ProjectListRepositoryImpl()),
    child: ConfigPage(),
  ));
  */

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProjectListBloc>(
        builder: (BuildContext context) =>
            ProjectListBloc(projectListRepository: ProjectListRepositoryImpl()),
      ),
      BlocProvider<ArticleBloc>(
        builder: (BuildContext context) =>
            ArticleBloc(repository: ArticleRepositoryImpl()),
      ),
    ],
    child: ConfigPage(),
  ));
}
