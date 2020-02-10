//main import
import 'package:flutter/material.dart';

//bloc import
import '../../config/config_bloc.dart';

//other import
import '../../utils/tools.dart';
import '../../resources/colors.dart';
import '../../resources/sizes.dart';

class ActionCard extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final Color color;

  const ActionCard({Key key, this.onPressed, this.icon, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size_08),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: ConfigBloc().darkModeOn
              ? Tools.hexToColor("#1f2124")
              : whiteColor,
          borderRadius: BorderRadius.circular(size_08),
          boxShadow: !ConfigBloc().darkModeOn
              ? [
                  BoxShadow(
                    color: grey200,
                    blurRadius: size_10,
                    spreadRadius: size_05,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: size_10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: size_12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
