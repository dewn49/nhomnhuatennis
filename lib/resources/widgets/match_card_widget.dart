import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter_app/resources/pages/match_view_page.dart';
import 'package:flutter_app/app/models/posts.dart';

class MatchCard extends StatefulWidget {
  const MatchCard({super.key, required this.private});

  static String state = "match_card";
  final NNMatch private;
  @override
  createState() => _MatchCardState();
}

class _MatchCardState extends NyState<MatchCard> {
  _MatchCardState() {
    stateName = MatchCard.state;
  }

  @override
  init() async {}

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(MatchCard.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   showModalBottomSheet(
      //     enableDrag: false,
      //     context: context,
      //     isScrollControlled: true,
      //     builder: (BuildContext context) {
      //       return Form(
      //         child: MatchViewPage(widget.private
      //             // height: 300.0,
      //             // width: 300.0,
      //             // child: Text( 'Thêm trận đấu', )
      //             ),
      //       );
      //     },
      //   );
      //   setState(() {});
      // },
      child: Container(
        // color: Color.fromARGB(255, 255, 247, 93),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 223, 255, 93),
        ), //BoxDecoration

        child: Row(
          children: <Widget>[
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    //
                    Text(mapMemberId[
                        int.tryParse(widget.private.getNhom()!['player1'])]!),
                    Text(mapMemberId[
                        int.tryParse(widget.private.getNhom()!['player2'])]!),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  // color: Color.fromARGB(255, 255, 247, 93),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color.fromARGB(255, 214, 245, 91),
                  ),
                  child: Text(
                    widget.private.getNhom()!['point'].toString(),
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
              child: Text(
                '|',
                textAlign: TextAlign.center,
              ),
            ), //SizedBox

            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  // color: Color.fromARGB(255, 255, 247, 93),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color.fromARGB(255, 214, 245, 91),
                  ),
                  child: Text(
                    widget.private.getNhua()!['point'].toString(),
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(children: [
                  Text(mapMemberId[
                      int.tryParse(widget.private.getNhua()!['player1'])]!),
                  Text(mapMemberId[
                      int.tryParse(widget.private.getNhua()!['player2'])]!),
                ]),
              ],
            ),
          ], //<Widget>[]
          mainAxisAlignment: MainAxisAlignment.center,
          // ),
        ),
      ),
    );
  }
}
