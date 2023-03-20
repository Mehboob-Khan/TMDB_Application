import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:sensors/sensors.dart';

class AccelerometerHandler {
  StreamSubscription<UserAccelerometerEvent>? _accelerometerSubscription;

  void Function(Color)? onShake;

  AccelerometerHandler({this.onShake}) {
    _accelerometerSubscription = userAccelerometerEvents.listen((event) {
      final double shakeThreshold = 15;
      if (event.x.abs() > shakeThreshold ||
          event.y.abs() > shakeThreshold ||
          event.z.abs() > shakeThreshold) {
        _changeBackgroundColor();
      }
    });
  }

  void _changeBackgroundColor() {
    if (onShake != null) {
      onShake!(Color(Random().nextInt(0xFFFFFFFF)));
    }
  }

  void dispose() {
    _accelerometerSubscription?.cancel();
  }
}
