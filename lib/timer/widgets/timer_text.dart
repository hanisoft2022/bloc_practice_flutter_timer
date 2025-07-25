import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/timer/bloc/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TimerBloc, TimerState, int>(
      selector: (state) => state.duration, // 상태 중 duration만 선택
      builder: (context, duration) {
        final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
        final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

        return Text('$minutesStr:$secondsStr', style: Theme.of(context).textTheme.headlineLarge);
      },
    );
  }
}
