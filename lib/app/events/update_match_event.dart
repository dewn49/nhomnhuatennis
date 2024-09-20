import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/app/controllers/match_controller.dart';
import 'package:flutter_app/resources/pages/dashboard_page.dart';
import 'package:flutter_app/resources/pages/match_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class UpdateMatchEvent implements NyEvent {
  @override
  final listeners = {
    DefaultListener: DefaultListener(),
  };
}

class DefaultListener extends NyListener {
  @override
  handle(dynamic eventData) async {
    await MatchController.reloadListMatch();
    eventData['setStateFn'](() {});
  }
}
