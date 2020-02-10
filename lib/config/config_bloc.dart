//main import
import 'package:bloc/bloc.dart';

//bloc import
import '../config/config_index.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {

  static final ConfigBloc _configBlocSingleton = ConfigBloc._internal();

  var currentState;

  factory ConfigBloc() {
    return _configBlocSingleton;
  }

  ConfigBloc._internal();

  bool darkModeOn = false;

  @override
  ConfigState get initialState => UninitializedConfigState();

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    try {
      yield UninitializedConfigState();
      yield await event.applyAsync(currentState: currentState , bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
