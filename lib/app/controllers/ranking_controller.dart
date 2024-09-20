import 'package:flutter_app/app/events/update_rank_event.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/pages/dashboard_page.dart';
import 'package:flutter_app/resources/pages/ranking_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/app/controllers/globals.dart';
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
    memberMatchStat[player] = stats;
    stats[NN_STAT_POINT] = stats[NN_STAT_WIN] * NN_POINT_PER_WIN +
        stats[NN_STAT_LOS] * NN_POINT_PER_LOS +
        stats[NN_STAT_TIE] * NN_POINT_PER_TIE;
  } else {
    if (memberMatchStat.containsKey(player) == false) return; // choi tau ah
    iWin > 0
        ? memberMatchStat[player]![NN_STAT_WIN] =
            memberMatchStat[player]![NN_STAT_WIN] + 1
        : 0;
    iWin == 0
        ? memberMatchStat[player]![NN_STAT_TIE] =
            memberMatchStat[player]![NN_STAT_TIE] + 1
        : 0;
    iWin < 0
        ? memberMatchStat[player]![NN_STAT_LOS] =
            memberMatchStat[player]![NN_STAT_LOS] + 1
        : 0;
    memberMatchStat[player]![NN_STAT_DEU] =
        memberMatchStat[player]![NN_STAT_DEU] + homePoint;
    memberMatchStat[player]![NN_STAT_POINT] =
        memberMatchStat[player]![NN_STAT_WIN] * NN_POINT_PER_WIN +
            memberMatchStat[player]![NN_STAT_LOS] * NN_POINT_PER_LOS +
            memberMatchStat[player]![NN_STAT_TIE] * NN_POINT_PER_TIE;
  }
}

void updatePlayerStatsWithTeam(NNMatch match, Map<dynamic, dynamic> homeTeam,
    String homePlayer, Map<dynamic, dynamic> guestTeam) {
  int player = int.parse(homeTeam[homePlayer]);
  int homePoint = homeTeam['point'];
  int guestPoint = guestTeam['point'];
  bool isUpdate = memberMatchStat.containsKey(player) == false ? false : true;
  updatePlayerStats(player, homePoint, guestPoint, isUpdate);
}

// void getMemberToday() {
//   memberMatchStat.clear();
//   for (var match in listMatch) {
//     updatePlayerStatsWithTeam(
//         match, match.getNhom()!, 'player1', match.getNhua()!);
//     updatePlayerStatsWithTeam(
//         match, match.getNhom()!, 'player2', match.getNhua()!);
//     updatePlayerStatsWithTeam(
//         match, match.getNhua()!, 'player1', match.getNhom()!);
//     updatePlayerStatsWithTeam(
//         match, match.getNhua()!, 'player2', match.getNhom()!);
//   }

//   //sort
//   memberMatchStat = Map.fromEntries(memberMatchStat.entries.toList()
//     ..sort((e1, e2) =>
//         e1.value[NN_STAT_POINT].compareTo(e2.value[NN_STAT_POINT])));
// }

// Bien tam thoi
Map<int, List<int>> memberMatchStat = {};

class RankingController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<void> updateRankingByMonth(int year, int mon, dynamic data) async {
    int? memberId = 4;

    String from = DateTime.utc(year, mon, 1).toString();
    String to = '';

    if (mon == 12) {
      to = DateTime.utc(year, mon, 31).toString();
    }
    if (mon == 13) {
      from = DateTime.utc(year, 1, 1).toString();
      to = DateTime.utc(year, 12, 31).toString();
    } else
      to = DateTime.utc(year, mon + 1, 1).toString();

    for (var member in listMember) {
      memberId = member.id;
      member.stats = [0, 0, 0, 0, 0];
      print('Các trận đấu của memberid: ' + memberId.toString());
      final matchInMonth = await Supabase.instance.client
          .from('nn_match')
          .select('*')
          .gte('finished_at', from)
          .lte('finished_at', to)
          .or('nhom1.eq.${memberId}, nhom2.eq.${memberId},nhua1.eq.${memberId}, nhua2.eq.${memberId}')
          .order('id', ascending: true);

      memberMatchStat.clear();
      for (var d in matchInMonth) {
        print(d);
        NNMatch match = NNMatch.fromJson(d);
        updatePlayerStatsWithTeam(
            match, match.getNhom()!, 'player1', match.getNhua()!);
        updatePlayerStatsWithTeam(
            match, match.getNhom()!, 'player2', match.getNhua()!);
        updatePlayerStatsWithTeam(
            match, match.getNhua()!, 'player1', match.getNhom()!);
        updatePlayerStatsWithTeam(
            match, match.getNhua()!, 'player2', match.getNhom()!);
      }
      if (memberMatchStat.length != 0)
        member.stats = memberMatchStat[memberId]!;
      print('/////////////////////////');
    }

    //sort
    listMember.sort(
        (e1, e2) => e2.stats[NN_STAT_POINT].compareTo(e1.stats[NN_STAT_POINT]));

    // updateState(RankingPage.path);
    // StateAction.refreshPage(RankingPage.path);
    // routeTo(DashboardPage.path);
    event<UpdateRankEvent>(
        data: {'setStateFn': data['setStateFn'], 'context': data['context']});
  }
}
