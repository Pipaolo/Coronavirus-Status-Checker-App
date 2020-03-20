import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  @override
  IntroState get initialState => IntroInitial();

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is IntroAppStarted) {
      final box = await Hive.openBox('instance');
      final isOpenedOnce = box.get('isOpenedOnce');
      if (isOpenedOnce != null) {
        yield IntroOpenedOnce();
      } else {
        yield IntroNotOpenedOnce();
      }
    } else if (event is IntroStored) {
      final box = await Hive.openBox('instance');
      box.put('isOpenedOnce', true);
    }
  }
}
