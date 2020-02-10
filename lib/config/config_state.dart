import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigState extends Equatable {
  ConfigState([List props = const <dynamic>[]]) : super();

  ConfigState getStateCopy();
}

class UninitializedConfigState extends ConfigState {
  @override
  String toString() => 'UnConfigState';
  @override
  ConfigState getStateCopy() {
    return UninitializedConfigState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitializedConfigState extends ConfigState {
  @override
  String toString() => 'InConfigState';
  @override
  ConfigState getStateCopy() {
    return InitializedConfigState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorConfigState extends ConfigState {
  final String errorMessage;

  ErrorConfigState(this.errorMessage);

  @override
  String toString() => 'ErrorConfigState';
  @override
  ConfigState getStateCopy() {
    return ErrorConfigState(this.errorMessage);
  }

  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}
