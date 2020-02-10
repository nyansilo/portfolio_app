import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio/data/model/api_result_model.dart';

import 'package:portfolio/data/model/project_list_model.dart';




abstract class ProjectListState extends Equatable {




}



class ProjectListInitializedState extends ProjectListState{

  @override
  //TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'loadingProjectListState';


}

class ProjectListLoadingState extends ProjectListState{

  @override
  String toString() => 'loadingProjectListState';
  List<Object> get props => [];



}

class ProjectListLoadedState extends ProjectListState{

   List<ProjectList> projectlist;
   ProjectListLoadedState({@required this.projectlist});


  @override
  String toString() => 'loadedProjectListState';

  @override
  // TODO: implement props
  List<Object> get props => [projectlist];


}

class ProjectListErrorState extends ProjectListState{

  final String errorMessage;

  ProjectListErrorState({this.errorMessage});

  @override
  String toString() => 'ErrorProjectListState ';

  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];

}


/*

@immutable
abstract class ProjectListState extends Equatable {


  ProjectListState([Iterable props]) : super(props);

  /// Copy object for use in action
  ProjectListState getStateCopy();

}



class ProjectListInitializedState extends ProjectListState{

  @override
  String toString() => 'loadingProjectListState';

  @override
  ProjectListInitializedState getStateCopy() {
    return ProjectListInitializedState();
  }

}

class ProjectListLoadingState extends ProjectListState{

  @override
  String toString() => 'loadingProjectListState';

  @override
  ProjectListLoadingState getStateCopy() {
    return ProjectListLoadingState();
  }

}

class ProjectListLoadedState extends ProjectListState{

  List<ProctectList> projectlist;

  ProjectListLoadedState(projectlist);

  @override
  String toString() => 'loadedProjectListState';

  @override
  ProjectListLoadedState  getStateCopy() {
    return ProjectListLoadedState(this.projectlist);
  }

}

class ProjectListErrorState extends ProjectListState{

  final String errorMessage;

  ProjectListErrorState(this.errorMessage);

  @override
  String toString() => 'ErrorProjectListState ';

  @override
  ProjectListErrorState  getStateCopy() {
    return ProjectListErrorState(this.errorMessage);
  }

}
*/
