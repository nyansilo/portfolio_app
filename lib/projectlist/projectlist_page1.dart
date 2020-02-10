
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/tools.dart';
import 'package:portfolio/data/model/project_list_model.dart';

import 'projectlist_index.dart';


class ProjectListPage extends StatefulWidget {

  static const String routeName = "/projectlist";
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {



  ProjectListBloc _projectListBloc;

  @override
  void initState() {
    super.initState();
    _projectListBloc = BlocProvider.of<ProjectListBloc>(context);
    _projectListBloc.add(FetchProjectListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Cricket"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _projectListBloc.add(FetchProjectListEvent());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      //navigateToAoutPage(context);
                    },
                  )
                ],
              ),
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
                        return buildProjectListList(state.projectlist);
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
      ),
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

  Widget buildProjectListList(List<ProjectList> projectlist) {
    return ListView.builder(
      itemCount: projectlist.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: projectlist[index].image,
                  child: Image.network(
                    projectlist[index].image,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(projectlist[index].name),
              subtitle: Text(dateFormatter(projectlist[index].created)),
            ),
            onTap: () {
              navigateToProjectListDetailPage(context, projectlist[index]);
            },
          ),
        );
      },
    );
  }

  void navigateToProjectListDetailPage(BuildContext context, ProjectList projectList) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProjectDetailPage(
        projectlist : projectList,
      );
    }));
  }

  //void navigateToAoutPage(BuildContext context) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) {
     // return AboutPage();
    //}));
  //}
}
