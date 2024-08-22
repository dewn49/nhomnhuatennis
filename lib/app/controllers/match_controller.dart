import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/widgets/match_card_widget.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_app/app/controllers/globals.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

// isUpdate = fasle: player la new, chua co trong stat thi thêm
// isUpdate = true: player la da co trong stat thi update
void updatePlayerStats(
    int player, int homePoint, int guestPoint, bool isUpdate) {
  int iWin = homePoint - guestPoint;
  if (isUpdate == false) {
    List<int> stats = [0, 0, 0, 0, 0];
    iWin > 0 ? stats[NN_STAT_WIN] = stats[NN_STAT_WIN] + 1 : 0;
    iWin == 0 ? stats[NN_STAT_TIE] = stats[NN_STAT_TIE] + 1 : 0;
    iWin < 0 ? stats[NN_STAT_LOS] = stats[NN_STAT_LOS] + 1 : 0;
    stats[NN_STAT_DEU] = homePoint;
    nnMatchStat[player] = stats;
    stats[NN_STAT_POINT] = stats[NN_STAT_WIN] * NN_POINT_PER_WIN +
        stats[NN_STAT_LOS] * NN_POINT_PER_LOS;
  } else {
    if (nnMatchStat.containsKey(player) == false) return; // choi tau ah
    iWin > 0
        ? nnMatchStat[player]![NN_STAT_WIN] =
            nnMatchStat[player]![NN_STAT_WIN] + 1
        : 0;
    iWin == 0
        ? nnMatchStat[player]![NN_STAT_TIE] =
            nnMatchStat[player]![NN_STAT_TIE] + 1
        : 0;
    iWin < 0
        ? nnMatchStat[player]![NN_STAT_LOS] =
            nnMatchStat[player]![NN_STAT_LOS] + 1
        : 0;
    nnMatchStat[player]![NN_STAT_DEU] =
        nnMatchStat[player]![NN_STAT_DEU] + homePoint;
    nnMatchStat[player]![NN_STAT_POINT] =
        nnMatchStat[player]![NN_STAT_WIN] * NN_POINT_PER_WIN +
            nnMatchStat[player]![NN_STAT_LOS] * NN_POINT_PER_LOS;
  }
}

void updatePlayerStatsWithTeam(NNMatch match, Map<dynamic, dynamic> homeTeam,
    String homePlayer, Map<dynamic, dynamic> guestTeam) {
  int player = int.parse(homeTeam[homePlayer]);
  int homePoint = homeTeam['point'];
  int guestPoint = guestTeam['point'];
  bool isUpdate = nnMatchStat.containsKey(player) == false ? false : true;
  updatePlayerStats(player, homePoint, guestPoint, isUpdate);
}

void getMemberToday() {
  nnMatchStat.clear();
  for (var match in listMatch) {
    updatePlayerStatsWithTeam(
        match, match.getNhom()!, 'player1', match.getNhua()!);
    updatePlayerStatsWithTeam(
        match, match.getNhom()!, 'player2', match.getNhua()!);
    updatePlayerStatsWithTeam(
        match, match.getNhua()!, 'player1', match.getNhom()!);
    updatePlayerStatsWithTeam(
        match, match.getNhua()!, 'player2', match.getNhom()!);
    // int player = int.parse(match.getNhom()?['player1']);
    // int homePoint = match.getNhom()?['point'];
    // int guestPoint = match.getNhua()?['point'];
    // bool isUpdate = nnMatchStat.containsKey(player) == false ? false : true;
    // updatePlayerStats(player, homePoint, guestPoint, isUpdate);
  }

  //sort
  nnMatchStat = Map.fromEntries(nnMatchStat.entries.toList()
    ..sort((e1, e2) =>
        e1.value[NN_STAT_POINT].compareTo(e2.value[NN_STAT_POINT])));
}

class MatchController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<void> reloadListMatch() async {
    String from = DateTime.utc(
            nnDateTimePlay['yy']!, nnDateTimePlay['mo']!, nnDateTimePlay['dd']!)
        .toString();
    String to = DateTime.utc(nnDateTimePlay['yy']!, nnDateTimePlay['mo']!,
            nnDateTimePlay['dd']! + 1)
        .toString();
    listMatch.clear();

    var data = await Supabase.instance.client
        .from('nn_match')
        .select('*')
        .gte('created_at', from)
        .lte('created_at', to)
        .order('id', ascending: false);
    print('----Reload----');
    for (var d in data) {
      print(d);
      listMatch.add(NNMatch.fromJson(d));
    }

    // Update statistic;
    getMemberToday();
  }
}
