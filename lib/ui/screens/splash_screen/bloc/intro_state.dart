part of 'intro_bloc.dart';

abstract class IntroState extends Equatable {
  const IntroState();
}

class IntroInitial extends IntroState {
  @override
  List<Object> get props => [];
}

class IntroOpenedOnce extends IntroState {
  @override
  List<Object> get props => [];
}

class IntroNotOpenedOnce extends IntroState {
  @override
  List<Object> get props => [];
}
