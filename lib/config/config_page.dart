//main import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/article/article_bloc.dart';
import 'package:portfolio/article/article_bloc.dart';
import 'package:portfolio/article/article_bloc.dart';
import 'package:portfolio/article/article_bloc.dart';
import 'package:portfolio/article/article_page.dart';
import 'package:portfolio/data/repositories/article_repository.dart';
import 'package:portfolio/dogcat/dogcat_screen.dart';
import 'package:portfolio/home/mypost.dart';
import 'package:portfolio/projectlist/projectlist_page.dart';
import 'package:portfolio/user/contact_me.dart';
import 'package:portfolio/user/user_profile_page.dart';

//bloc pages import
import 'config_index.dart';
import '../home/home_page.dart';
//import '../agenda/agenda_page.dart';
//import '../speaker/speaker_page.dart';
//import '../sponsor/sponsor_page.dart';
//import '../faq/faq.dart';

//resources import
import '../utils/app_localizations.dart';
import '../resources/colors.dart';
import '../resources/app_settings.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() {
    configBloc = ConfigBloc();

    configBloc.darkModeOn =
        AppSettings.prefs.getBool(AppSettings.darkModePref) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      builder: (context) => configBloc,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'My Portfolio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //* Custom Google Font
              fontFamily: AppSettings.google_sans_family,
              primarySwatch: redColor,
              primaryColor: configBloc.darkModeOn ? blackColor : whiteColor,
              disabledColor: greyColor,
              cardColor: configBloc.darkModeOn ? blackColor : whiteColor,
              canvasColor: configBloc.darkModeOn ? blackColor : grey50,
              brightness:
                  configBloc.darkModeOn ? Brightness.dark : Brightness.light,
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  colorScheme: configBloc.darkModeOn
                      ? ColorScheme.dark()
                      : ColorScheme.light()),
              appBarTheme: AppBarTheme(
                elevation: 0.0,
              ),
            ),
            home: HomePage(),
            routes: {
              HomePage.routeName: (context) => HomePage(),
              UserProfilePage.routeName: (context) => UserProfilePage(),
              ProjectListPage.routeName: (context) => ProjectListPage(),
              ContactMePage.routeName: (context) => ContactMePage(),
              ArticlePage.routeName: (context) => ArticlePage(),

              //SponsorsPage.routeName: (context) => SponsorsPage(),
              //FaqPage.routeName: (context) => FaqPage(),
            },
          );
        },
      ),
    );
  }
}
