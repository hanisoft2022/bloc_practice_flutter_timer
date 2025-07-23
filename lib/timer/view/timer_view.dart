import 'package:flutter/material.dart' hide Actions;

import '../widgets/widgets.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  int _inputSecond = 90; // 최초 기본값

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: TimerText()),
              const SizedBox(height: 30),
              Actions(inputSecond: _inputSecond),
            ],
          ),
        ],
      ),
    );
  }
}
