import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MemberStatistic extends StatefulWidget {
  
  const MemberStatistic({super.key});
  
  static String state = "member_statistic";

  @override
  createState() => _MemberStatisticState();
}

class _MemberStatisticState extends NyState<MemberStatistic> {

  _MemberStatisticState() {
    stateName = MemberStatistic.state;
  }

  @override
  init() async {
    
  }
  
  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(MemberStatistic.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
