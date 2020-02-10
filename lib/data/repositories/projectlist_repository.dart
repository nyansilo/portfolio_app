import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:portfolio/data/model/project_list_model.dart';
import 'package:portfolio/res/strings.dart';
import 'package:portfolio/utils/api_util.dart';

/*abstract class ProjectListRepository {
  Future<List<ProjectList>> getProjectList();
}

class ProjectListRepositoryImpl implements ProjectListRepository {

  @override
  Future<List<ProjectList>> getProjectList() async {

    var response = await http.get(AppStrings.portfolioUrl);
    List<ProjectList> projectlist = [];
    if (response.statusCode == 200) {


      Map<String, dynamic> body = json.decode(response.body);



      for( var item in  body['data']) {

        ProjectList list = ProjectList.fromJson(item);

        projectlist.add(list);

      }

      //return json.decode(response.body).map<ProjectList>((item) => ProjectList.fromJson(item)).toList();
      //return projectlist;
    } else {
      throw Exception();
    }
  }*/

abstract class ProjectListRepository {
  Future<List<ProjectList>> getProjectList();
}

class ProjectListRepositoryImpl implements ProjectListRepository {
  @override
  Future<List<ProjectList>> getProjectList() async {

    String allProjects = ApiUtil.MAIN_API_URL + ApiUtil.ALL_PROJECTS;

    var response = await http.get(allProjects );

    if (response.statusCode == 200) {
      List projectlist = jsonDecode(response.body);
      List<ProjectList> projects = [];
      for (var projectMap in projectlist) {
        projects.add(ProjectList.fromJson(projectMap));
      }
      return projects;
    } else {
      throw Exception('Failed to load themes');
    }
  }
}
