import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/pages/match_view_page.dart';
import 'package:flutter_app/resources/widgets/match_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/app/controllers/match_controller.dart';

class MatchPage extends NyStatefulWidget<MatchController> {
  static const path = '/match';

  MatchPage({super.key}) : super(path, child: () => _MatchPageState());
}

class _MatchPageState extends NyState<MatchPage> {
  _MatchPageState() {
    // widget.controller.state = 'match_page';
    stateName = 'match_page';
  }

  /// [MatchController] controller
  MatchController get controller => widget.controller;

  @override
  init() async {
    // final data = await Supabase.instance.client.from('nn_match').select('*');
    // for (var d in data) {
    //   print(d);
    //   listMatch.add(NNMatch.fromJson(d));
    // }
  }

  /// Use boot if you need to load data before the view is rendered.
  @override
  boot() async {
    await controller.reloadListMatch();
  }

  refresh(bool isAdd) {
    setState(() {
      if (isAdd) controller.reloadListMatch();
    });
  }

  Future<void> updateMatch(NNMatch nnMatch) async {
    // ignore: unused_local_variable
    final bool? shouldRefresh = await showModalBottomSheet<bool>(
        enableDrag: false,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Form(
            child: MatchViewPage(nnMatch, refresh),
          );
        });
  }

  @override
  Widget view(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      // appBar: AppBar(title: const Text("Match")),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Nhật ký  ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(
                      color: colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: () => _selectDate(context), // Refer step 3
                child: Text(
                  'Đổi',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onError,
                  backgroundColor: Color.fromARGB(255, 205, 255, 112),
                ),
                onPressed: () {
                  setState(() {});
                }, // Refer step 3
                child: Text(
                  'Refresh',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 22),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 44, 26, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC4C4C4).withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, -4), // changes position of shadow
                  ),
                ],
              ),
              child: NyListView.separated(
                child: (BuildContext context, dynamic data) {
                  data as NNMatch;
                  return InkWell(
                    child: MatchCard(private: data),
                    onTap: () {
                      updateMatch(data);
                    },
                  ); //Container
                },
                data: () async {
                  return listMatch;
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateMatch(NNMatch());
        },
        tooltip: 'Thêm trận đấu',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      nnUpdateDateTimePlay(picked.year, picked.month, picked.day, picked.hour,
          picked.minute, picked.second);

      setState(() {
        selectedDate = picked;
        controller.reloadListMatch();
      });
    }
  }
}
