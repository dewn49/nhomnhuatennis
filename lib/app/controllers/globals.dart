library nhomnhuatv.globals;

import 'package:flutter_app/app/models/posts.dart';

bool isLoggedIn = false;

List<Member> listMember = [];

Map<int, String> mapMemberId = {};

List<NNMatch> listMatch = [];

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
