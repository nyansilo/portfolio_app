//main import
import 'package:bloc/bloc.dart';

//bloc , pages , screens import
import '../home/home_index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();

  var currentState;

  factory HomeBloc() {
    return _homeBlocSingleton;
  }

  HomeBloc._internal();

  @override
  HomeState get initialState => UninitializedHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      yield UninitializedHomeState();
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}