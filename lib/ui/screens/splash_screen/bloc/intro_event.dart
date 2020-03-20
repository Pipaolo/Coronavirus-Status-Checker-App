part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();
}

class IntroAppStarted extends IntroEvent {
  @override
  List<Object> get props => [];
}

class IntroStored extends IntroEvent {
  final bool isOpenedOnce;

  IntroStored({this.isOpenedOnce});
  @override
  List<Object> get props => [isOpenedOnce];
}
