import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class UpdateRankEvent implements NyEvent {
  @override
  final listeners = {
    DefaultListener: DefaultListener(),
  };
}

class DefaultListener extends NyListener {
  @override
  handle(dynamic eventData) async {
    // Handle the event
    Navigator.pop(eventData['context']);
    eventData['setStateFn'](() {});
  }
}
