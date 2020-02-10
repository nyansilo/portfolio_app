//main import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/article/article_page.dart';
import 'package:portfolio/dogcat/dogcat_screen.dart';
import 'package:portfolio/projectlist/projectlist_page.dart';
import 'package:portfolio/user/contact_me.dart';
import 'package:portfolio/user/user_profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

//bloc import
import '../../config/config_bloc.dart';

//page import
//import '../../agenda/agenda_page.dart';
//import '../../speaker/speaker_page.dart';
//import '../../sponsor/sponsor_page.dart';
//import '../../faq/faq.dart';

//widget import

import '../mypost.dart';
import 'action_card.dart';

//other import
import '../../universal/image_card.dart';
import '../../resources/strings.dart';
import '../../resources/sizes.dart';
import '../../resources/icons.dart';
import '../../resources/colors.dart';
import '../../resources/app_settings.dart';

class HomeFront extends StatelessWidget {
//Url Launcher function for social medial
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '$could_not_launch $url';
    }
  }

//Intoduction Conference Headline and Discription widget list
  List<Widget> conferenceTexts(context) => [
        Text(
          welcomeText,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size_10,
        ),
        Text(
          descText,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.justify,
        ),
      ];

//Page Action Navigation Actions Widget
  Widget pageActions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: size_20,
        runSpacing: size_20,
        children: <Widget>[
          ActionCard(
            icon: personIcon,
            color: greyColor,
            title: about_text,
            onPressed: () => Navigator.pushNamed(context, UserProfilePage.routeName),
          ),
          ActionCard(
            icon: scheduleIcon,
            color: redColor,
            title: project_text,
            onPressed: () => Navigator.pushNamed(context, ProjectListPage.routeName),
          ),

          ActionCard(
            icon: personIcon,
            color: amberColor,
            title: contact_text,
            onPressed: () => Navigator.pushNamed(context, ContactMePage.routeName),
          ),
          ActionCard(
            icon: attachMoneyIcon,
            color: purpleColor,
            title: sponsor_text,
            onPressed: () => Navigator.pushNamed(context, ArticlePage.routeName),
          ),
          ActionCard(
            icon: questionAnsIcon,
            color: brownColor,
            title: faq_text,
            //onPressed: () => {
              //Navigator.pushNamed(context, FaqPage.routeName),
            //},
          ),
          ActionCard(
            icon: mapIcon,
            color: blueColor,
            title: map_text,
            onPressed: () => {},
          )
        ],
      );

//Social Media Action widges
  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookF),
              onPressed: () async {
                await _launchURL(AppSettings.facebook);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL(AppSettings.twitter);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.linkedinIn),
              onPressed: () async {
                _launchURL(AppSettings.linkedIn);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.youtube),
              onPressed: () async {
                await _launchURL(AppSettings.youtube);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.meetup),
              onPressed: () async {
                await _launchURL(AppSettings.meetup);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.envelope),
              onPressed: () async {
                var emailUrl =
                    '''mailto:danielgeuza808@gmail.com?subject=Support Needed For DevFest App&body={Name: Pawan Kumar},Email: pawan221b@gmail.com}''';
                var out = Uri.encodeFull(emailUrl);
                await _launchURL(out);
              },
            ),
          ],
        ),
      );

//Main buid widget
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(size_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageCard(
              img: ConfigBloc().darkModeOn
                  ? AppSettings.banner_dark
                  : AppSettings.banner_light,
            ),
            SizedBox(
              height: size_20,
            ),
            ...conferenceTexts(context),
            SizedBox(
              height: size_20,
            ),
            pageActions(context),
            SizedBox(
              height: size_20,
            ),
            socialActions(context),
            SizedBox(
              height: size_20,
            ),
            Text(
              AppSettings.app_version,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: size_10),
            )
          ],
        ),
      ),
    );
  }
}
