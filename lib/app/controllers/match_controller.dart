import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/widgets/match_card_widget.dart';
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
    final data = await Supabase.instance.client.from('nn_match').select('*');
    listMatch.clear();
    print('----Reload----');
    for (var d in data) {
      print(d);
      listMatch.add(NNMatch.fromJson(d));
    }
  }
}
