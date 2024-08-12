import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/widgets/match_card_widget.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_app/app/controllers/globals.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

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
  }
}
