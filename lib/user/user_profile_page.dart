import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/resources/app_settings.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/universal/conf_scaffold.dart';
import 'package:portfolio/user/user_widget/info_card.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  static const String routeName = "/user-profile";

  final String _fullName = "Daniel George";
  final String _status = "Data Scientist";
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";
  static const url = 'http://myportfolio.net';
  static const email = 'danielgeuza808@com.com';
  static const phone = '+86 152 1101 4556';
  static const loc = 'Changsha, Hunan';


  //Url Launcher function for social medial
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
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

/*
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }*/

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 180.0,
        height: 180.0,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          image: DecorationImage(
              image: AssetImage('assets/images/daniel.jpg'),
              fit: BoxFit.contain),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }


  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]},",
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
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildContactInfo(context),
                  SizedBox(height: 8.0),
                  _socialActions(context)
                ],
              ),
            ),
          ),
        ],
      ),
      title: 'My Profile',
    );
  }
}
