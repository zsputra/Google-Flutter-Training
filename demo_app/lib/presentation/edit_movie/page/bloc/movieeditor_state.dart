part of 'movieeditor_bloc.dart';

@immutable
abstract class MovieeditorState {
  const MovieeditorState();
}

@immutable
class MovieEditorError extends MovieeditorState {
  final dynamic error;

  MovieEditorError(this.error);
}

@immutable
class MovieeditorInitial extends MovieeditorState {
  @override
  List<Object> get props => [];
}

@immutable
class OnSuccessSave extends MovieeditorState {}
