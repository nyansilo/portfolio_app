import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/data/model/project_list_model.dart';
import 'package:portfolio/projectlist/projectlist_bloc.dart';
import 'package:portfolio/projectlist/projectlist_event.dart';
import 'package:portfolio/projectlist/projectlist_index.dart';
import 'package:portfolio/utils/tools.dart';

class DataScienceScreen extends StatefulWidget {
  static const String routeName = "/ml";
  @override
  _DataScienceScreenState createState() => _DataScienceScreenState();
}

class _DataScienceScreenState extends State<DataScienceScreen> {
  ProjectListBloc _projectListBloc;

  @override
  void initState() {
    super.initState();
    _projectListBloc = BlocProvider.of<ProjectListBloc>(context);
    _projectListBloc.add(FetchProjectListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Material(
          child: Scaffold(
            body: Container(
              child: BlocListener<ProjectListBloc, ProjectListState>(
                listener: (context, state) {
                  if (state is ProjectListErrorState) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                child: BlocBuilder<ProjectListBloc, ProjectListState>(
                  builder: (context, state) {
                    if (state is ProjectListInitializedState) {
                      return buildLoading();
                    } else if (state is ProjectListLoadingState) {
                      return buildLoading();
                    } else if (state is ProjectListLoadedState) {
                      return buildProjectList(state.projectlist);
                    } else if (state is ProjectListErrorState) {
                      return buildErrorUi(state.errorMessage);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildProjectList(List<ProjectList> projectlist) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: projectlist.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailPage(
                    projectlist: projectlist[i],
                  ),
                ),
              );
            },
            // dense: true,
            isThreeLine: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                //text: "${projectlist[i].name}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    //text: projectlist[i].created,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            leading: Hero(
              tag: projectlist[i].image,
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    CachedNetworkImageProvider(projectlist[i].image),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: "${projectlist[i].name}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: 'Created: ',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  TextSpan(
                      text: dateFormatter(projectlist[i].created),
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: []),
                ],
              ),
            ),
            subtitle: Text(
              projectlist[i].description,
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 12.0,
                  ),
            ),
          ),
        );
      },
    );
  }
}
