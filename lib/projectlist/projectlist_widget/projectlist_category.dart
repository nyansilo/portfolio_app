//import 'dart:math';

//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/material.dart';

//import 'package:portfolio/data/model/project_list_model.dart';

//import '../../utils/tools.dart';

/*

class ProjectListCategory extends StatelessWidget {
  final List<ProjectList> allSessions;

  const ProjectListCategory({Key key, @required this.allSessions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allSessions.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => SessionDetail(
                    //session: allSessions[i],
                 // ),
                ),
              );
            },
            // dense: true,
            isThreeLine: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${allSessions[i].sessionTotalTime}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: allSessions[i].sessionStartTime,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            leading: Hero(
              tag: allSessions[i].image,
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                CachedNetworkImageProvider(allSessions[i].image),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: "${allSessions[i].name}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                      text: allSessions[i].speakerName,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                        fontSize: 14,
                        color: Tools.multiColors[Random().nextInt(4)],
                      ),
                      children: []),
                ],
              ),
            ),
            subtitle: Text(
              allSessions[i].speakerDesc,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 10.0,
              ),
            ),
          ),
        );
      },
    );
  }
}*/
