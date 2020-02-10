
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:portfolio/data/model/api_result_model.dart';
import 'package:portfolio/data/model/project_list_model.dart';

import '../projectlist/projectlist_index.dart';
import '../data/repositories/projectlist_repository.dart';





class ProjectListBloc extends Bloc<ProjectListEvent,ProjectListState> {


  final ProjectListRepository projectListRepository;

  ProjectListBloc({this.projectListRepository}) : assert(projectListRepository != null);


  @override
  // TODO: implement initialState
  ProjectListState get initialState => ProjectListInitializedState();

  @override
  Stream<ProjectListState> mapEventToState(ProjectListEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchProjectListEvent) {
       yield ProjectListLoadingState();
       try {
            List<ProjectList> projectlist = await projectListRepository.getProjectList();
           yield ProjectListLoadedState(projectlist: projectlist);

       } catch (e) {
         yield ProjectListErrorState(errorMessage : e.toString());

       }
    }
  }



}