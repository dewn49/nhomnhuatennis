import 'package:flutter_app/app/models/posts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/controllers/globals.dart';

class MatchViewController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<NNMatch> addMatch(NNMatch nnMatch) async {
    try {
      final response = await Supabase.instance.client.from('nn_match').insert(
        [
          {
            'nhom1': nnMatch.nhom['player1'],
            'nhom2': nnMatch.nhom['player2'],
            'nhua1': nnMatch.nhua['player1'],
            'nhua2': nnMatch.nhua['player2'],
            'nhom_point': 0,
            'nhua_point': 0,
            'meta': '{"state":"planning"}',
            'finished_at': DateTime.now().toString(),
          },
        ],
      ).select();

      if (response.isNotEmpty) {
        print('ADD++Response:  + $response');
        nnMatch.id = int.parse(response[0]['id'].toString());
        // listMatch.add(NNMatch.fromJson(nnMatch.toJson()));
        return nnMatch;
      } else {
        print('ADD++Unexpected response: $response');
        return nnMatch;
      }
    } catch (e) {
      print('ADD++Error adding city: $e');
      return nnMatch;
    }
  }

  Future<List<NNMatch>> updateMatch(int id, Map<dynamic, dynamic> nhom,
      Map<dynamic, dynamic> nhua, bool isFinish) async {
    var updates = {};
    if (isFinish)
      updates = {
        'id': id,
        'nhom1': nhom['player1'],
        'nhom2': nhom['player2'],
        'nhua1': nhua['player1'],
        'nhua2': nhua['player2'],
        'nhom_point': nhom['point'],
        'nhua_point': nhua['point'],
        'meta': '{"state":"finished"}',
        'finished_at': DateTime.now().toString(),
      };
    else
      updates = {
        'id': id,
        'nhom1': nhom['player1'],
        'nhom2': nhom['player2'],
        'nhua1': nhua['player1'],
        'nhua2': nhua['player2'],
        'nhom_point': nhom['point'],
        'nhua_point': nhua['point'],
        'meta': '{"state":"inprogress"}',
        'finished_at': DateTime.now().toString(),
      };

    try {
      final response = await Supabase.instance.client
          .from('nn_match')
          .upsert(updates)
          .select();
      if (response.isNotEmpty) {
        print('UPDATE++Response: $response');

        // final data =
        //     await Supabase.instance.client.from('nn_match').select('*');
        // listMatch.clear();
        // for (var d in data) {
        //   print(d);
        //   listMatch.add(NNMatch.fromJson(d));
        // }

        return response.cast<NNMatch>();
      } else {
        print('UPDATE++Unexpected response: $response');
        return [];
      }
    } catch (e) {
      print('UPDATE++Error adding city: $e');
      return [];
    }
  }

  Future<void> deleteMatch(int id) async {
    try {
      final response =
          await Supabase.instance.client.from('nn_match').delete().eq('id', id);
      print('delete ok');
      // StateAction.refreshPage('/match');
      // context?.showSnackBar('Successfully updated profile!');
    } on PostgrestException catch (error) {
      print('Loi delete by on PostgrestException');
      // if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      print('Loi delete by catch');
      // if (mounted) {
      //   context.showSnackBar('Unexpected error occurred', isError: true);
      // }
    } finally {
      print('Finally delete');
      // if (mounted) {
      //   setState(() {
      //     _loading = false;
      //   });
      // }
    }
  }
}
