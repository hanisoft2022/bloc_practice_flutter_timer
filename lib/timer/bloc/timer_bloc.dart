import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int initialDuration;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker, required this.initialDuration})
    : _ticker = ticker,
      super(TimerInitial(initialDuration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<_TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      emit(TimerRunPause(state.duration));
      _tickerSubscription?.pause();
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      emit(TimerRunInProgress(state.duration));
      _tickerSubscription?.resume();
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    emit(TimerInitial(initialDuration));
    _tickerSubscription?.cancel();
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete());
  }
}
