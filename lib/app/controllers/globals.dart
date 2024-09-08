library nhomnhuatv.globals;

import 'package:flutter_app/app/models/posts.dart';

bool isLoggedIn = false;

List<Member> listMember = [];

// get name by member id
Map<int, String> mapMemberId = {};

List<NNMatch> listMatch = [];

//Thong ke ket qua player trong 1 ngay thi dau
//int : memberId
//List<int> = [win, tie, los, deuce, point];
const int NN_STAT_WIN = 0;
const int NN_STAT_TIE = 1;
const int NN_STAT_LOS = 2;
const int NN_STAT_DEU = 3;
const int NN_STAT_POINT = 4;
Map<int, List<int>> nnMatchStat = {};
const int NN_POINT_PER_WIN = 3;
const int NN_POINT_PER_LOS = -1;
const int NN_POINT_PER_TIE = 1;
// First update khi login
Map<String, int> nnDateTimePlay = {
  'yy': 2024,
  'mo': 8,
  'dd': 10,
  'hh': 0,
  'mi': 0,
  'ss': 0
};

void nnUpdateDateTimePlay(int y, int m, int d, int h, int M, int s) {
  nnDateTimePlay['yy'] = y;
  nnDateTimePlay['mo'] = m;
  nnDateTimePlay['dd'] = d;
  nnDateTimePlay['hh'] = h;
  nnDateTimePlay['mi'] = M;
  nnDateTimePlay['ss'] = s;
}

DateTime selectedDate = DateTime.now();
