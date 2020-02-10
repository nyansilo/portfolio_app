import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/resources/app_settings.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/universal/conf_scaffold.dart';
import 'package:portfolio/user/user_widget/info_card.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;


class ContactMePage extends StatelessWidget {
  static const String routeName = "/contact-me";

  static const url = 'http://myportfolio.net';
  static const email = 'danielgeuza808@com.com';
  static const phone = '+86 152 1101 4556';
  static const loc = 'Changsha, Hunan';

  //Url Launcher function for social medial
  _launchURL(String url) async {
    if (await launcher.canLaunch(url)) {
      await launcher.launch(url);
    } else {
      throw '$could_not_launch $url';
    }
  }

  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
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
  }


  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with Me",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InfoCard(
          text: phone,
          icon: Icons.phone,
          onPressed: () async {
            String removeSpaceFromPhoneNumber =
            phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
            final phoneCall = 'tel:$removeSpaceFromPhoneNumber';

            if (await launcher.canLaunch(phoneCall)) {
              await launcher.launch(phoneCall);
            } else {
              _showDialog(
                context,
                title: 'Sorry',
                msg: 'Phone number can not be called. Please try again!',
              );
            }
          },
        ),
        InfoCard(
          text: email,
          icon: Icons.email,
          onPressed: () async {
            final emailAddress = 'mailto:$email';

            if (await launcher.canLaunch(emailAddress)) {
              await launcher.launch(emailAddress);
            } else {
              _showDialog(
                context,
                title: 'Sorry',
                msg: 'Email can not be send. Please try again!',
              );
            }
          },
        ),
        InfoCard(
          text: url,
          icon: Icons.web,
          onPressed: () async {
            if (await launcher.canLaunch(url)) {
              await launcher.launch(url);
            } else {
              _showDialog(
                context,
                title: 'Sorry',
                msg: 'URL can not be opened. Please try again!',
              );
            }
          },
        ),
        InfoCard(
          text: loc,
          icon: Icons.location_city,
          onPressed: () {
            _showDialog(
              context,
              title: 'Hello',
              msg: 'Here is where I live thank you for visiting',
            );
          },
        ),
      ],
    );
  }


  //Social Media Action widges
  Widget _socialActions(context) => FittedBox(
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


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ConfScaffold(
      body: Stack(
        children: <Widget>[
          //_buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //SizedBox(height: screenSize.height / 6.4),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildContactInfo(context),
                  _socialActions(context)
                ],
              ),
            ),
          ),
        ],
      ),
      title: 'Contact Me',
    );
  }
}
