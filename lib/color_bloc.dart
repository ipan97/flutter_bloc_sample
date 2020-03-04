import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { to_amber, to_light_blue }

class ColorBloc {
  Color _color = Colors.amber;

  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();

  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  StreamController<Color> _stateController = StreamController<Color>();

  StreamSink<Color> get _stateSink => _stateController.sink;

  Stream<Color> get stateStream => _stateController.stream;

  ColorBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_amber) {
      _color = Colors.amber;
    } else {
      _color = Colors.lightBlue;
    }
    _stateSink.add(_color);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
