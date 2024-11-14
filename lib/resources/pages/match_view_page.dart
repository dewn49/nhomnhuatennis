import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/match_view_controller.dart';
import 'package:flutter_app/app/controllers/globals.dart';

class MatchViewPage extends NyStatefulWidget<MatchViewController> {
  static const path = '/match-view';

  MatchViewPage(this.nnMatch, this.notifyParent, {super.key})
      : super(path, child: () => _MatchViewPageState());
  final NNMatch nnMatch;
  final Function(bool) notifyParent;
}

class _MatchViewPageState extends NyState<MatchViewPage> {
  /// [MatchViewController] controller
  MatchViewController get controller => widget.controller;

  @override
  init() async {}

  /// Use boot if you need to load data before the view is rendered.
  @override
  boot() async {}

  TextEditingController nhom1 = TextEditingController();
  String nhom1Str = 'Player1';
  TextEditingController nhom2 = TextEditingController();
  TextEditingController nhua1 = TextEditingController();
  TextEditingController nhua2 = TextEditingController();

  // Initial Selected Value
  String nhom_point = '0';
  String nhua_point = '0';
  // List of items in our dropdown menu
  var items = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];

  String? getPlayerNameByOrder(Map<dynamic, dynamic> team, int oder) {
    if (widget.nnMatch.id == null) return 'Player ' + oder.toString();
    if (oder == 1) return mapMemberId[int.tryParse(team['player1'])];
    if (oder == 2) return mapMemberId[int.tryParse(team['player2'])];
    return '';
  }

  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  Map<Member, bool> selectedPlayers = {};

  void showListMemberSelection() {
    selectedPlayers.clear();
    listMember.forEach((member) {
      selectedPlayers[member] = false;
    });
    showModalBottomSheet(
      // enableDrag: false,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return new Scaffold(
            appBar: new AppBar(title: new Text('Select member')),
            body: new ListView(
              children: selectedPlayers.keys.map((Member key) {
                return Center(
                  child: CheckboxListTile(
                    title: new Text(key.name!),
                    value: selectedPlayers[key],
                    onChanged: (value) {
                      setState(() {
                        selectedPlayers[key] = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          );
        });
      },
    );
  }

  @override
  Widget view(BuildContext context) {
    if (widget.nnMatch.id != null) {
      nhom_point = widget.nnMatch.nhom!['point'].toString();
      nhua_point = widget.nnMatch.nhua!['point'].toString();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông tin trận đấu',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 255, 255, 0),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              size: 32,
            ),
            tooltip: 'Lưu thông tin',
            onPressed: onSaveMatch,
            color: Colors.green.shade400,
          ),
          IconButton(
            icon: const Icon(
              Icons.stop,
              size: 48,
            ),
            tooltip: 'Kết thúc trận đấu',
            onPressed: onFinishMatch,
            color: Colors.red.shade400,
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 32,
            ),
            tooltip: 'Xóa trận đấu',
            onPressed: onDelMatch,
            color: Color.fromARGB(255, 8, 84, 146),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 1,
              // ),
              Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 237, 237, 237),
                    ), //BoxDecoration
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 146, 255, 79),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "  Đội Nhôm (Alumi)  ",
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(border: Border.all()),
                                child: DropdownButton(
                                  // Initial Value
                                  value: nhom_point,
                                  // Down Arrow Icon
                                  // icon: const Icon(Icons.keyboard_arrow_down),
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 30,
                                  ),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      nhom_point = newValue!;
                                      widget.nnMatch.nhom['point'] = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: onSelectMemberNhomButton,
                          child: Text('Select members'),
                        ),
                        // TextButton(
                        //   // style: ButtonStyle(
                        //   //   foregroundColor:
                        //   //       MaterialStateProperty.all<Color>(Colors.blue),
                        //   // ),
                        //   style: ButtonStyle(
                        //     foregroundColor:
                        //         WidgetStateProperty.all<Color>(Colors.blue),
                        //     backgroundColor: WidgetStateProperty.all<Color>(
                        //         const Color.fromARGB(255, 33, 243, 236)),
                        //   ),
                        //   onPressed: onSelectMemberNhomButton,
                        //   child: Text(nhom1),
                        // ),
                        NyTextField(
                          controller: nhom1,
                          enabled: false,
                          dummyData:
                              getPlayerNameByOrder(widget.nnMatch.nhom, 1),
                          style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        NyTextField(
                          controller: nhom2,
                          enabled: false,
                          dummyData:
                              getPlayerNameByOrder(widget.nnMatch.nhom, 2),
                          style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), //Container
                  SizedBox(
                    width: 10,
                  ), //SizedBox
                  Container(
                    width: 200,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 237, 237, 237),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 182, 79),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "  Đội Nhựa (Plastic)  ",
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // points
                          alignment: Alignment.center,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: DropdownButton(
                            // Initial Value
                            value: nhua_point,

                            // Down Arrow Icon
                            // icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                nhua_point = newValue!;
                                widget.nnMatch.nhua['point'] = newValue;
                              });
                            },
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: onSelectMemberNhuaButton,
                          child: Text('Select members'),
                        ),
                        // DecoratedBox(
                        //   decoration: BoxDecoration(
                        //     // color: Color.fromARGB(255, 255, 182, 79),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Container(
                        //     height: 30,
                        //     child:
                        NyTextField(
                          controller: nhua1,
                          enabled: false,
                          dummyData:
                              getPlayerNameByOrder(widget.nnMatch.nhua, 1),
                          style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //   ),
                        // ),
                        NyTextField(
                          controller: nhua2,
                          enabled: false,
                          dummyData:
                              getPlayerNameByOrder(widget.nnMatch.nhua, 2),
                          style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ), //BoxDecoration
                  ) //Container
                ], //<Widget>[]
                mainAxisAlignment: MainAxisAlignment.center,
              ), //Row
              Container(
                width: 380,
                // height: 100,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.blue),
                // child: Column(
                //   children: [
                //     MaterialButton(
                //       onPressed: onSaveMatch,
                //       child: Text(
                //         'Lưu (Save)',
                //         style: GoogleFonts.workSans(
                //           textStyle: TextStyle(
                //             fontSize: 20,
                //             color: Colors.black,
                //             fontStyle: FontStyle.normal,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     ),
                //     MaterialButton(
                //       onPressed: onFinishMatch,
                //       child: Text(
                //         'Kết thúc (End game)',
                //         style: GoogleFonts.workSans(
                //           textStyle: TextStyle(
                //             fontSize: 20,
                //             color: Colors.black,
                //             fontStyle: FontStyle.normal,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     ),
                //     MaterialButton(
                //       onPressed: onDelMatch,
                //       child: Text(
                //         'Xóa (Delete)',
                //         style: GoogleFonts.workSans(
                //           textStyle: TextStyle(
                //             fontSize: 20,
                //             color: Colors.black,
                //             fontStyle: FontStyle.normal,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ), //BoxDecoration
              ), //Container
              SizedBox(
                height: 100,
              ),
            ], //<widget>[]
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ), //Column
        ) //Padding
            ),
      ),
    );
  }

  void onSaveMatch() async {
    if (widget.nnMatch.id == null) {
      await controller.addMatch(widget.nnMatch);
      listMatch.forEach((m) {
        print(m.toJson());
      });
      Navigator.of(context).pop(true);
      showToastSuccess(
          description: "Thêm trận đấu thành công. Bấm tiếp REFRESH");
      widget.notifyParent(true);
    } else {
      controller.updateMatch(
          widget.nnMatch.id!, widget.nnMatch.nhom, widget.nnMatch.nhua, false);
      Navigator.of(context).pop(true);
      widget.notifyParent(false);
    }
  }

  void onFinishMatch() {
    if (widget.nnMatch.id != null)
      controller.updateMatch(
          widget.nnMatch.id!, widget.nnMatch.nhom, widget.nnMatch.nhua, true);
    Navigator.of(context).pop(true);
    widget.notifyParent(false);
  }

  void onDelMatch() {
    if (widget.nnMatch.id != null) {
      controller.deleteMatch(widget.nnMatch.id!);
      listMatch.remove(widget.nnMatch);
    }
    Navigator.of(context).pop(true);
    widget.notifyParent(false);
  }

  void onSelectMemberButton(bool isNhom) {
    selectedPlayers.clear();
    listMember.forEach((member) {
      selectedPlayers[member] = false;
    });
    showDialog(
      // enableDrag: false,
      context: context,
      // isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return new Scaffold(
            appBar: new AppBar(
                title: new Text('Select member'),
                leading: IconButton(
                  onPressed: () {
                    int count = 0;
                    selectedPlayers.forEach((member, isChecked) {
                      if (isNhom) {
                        if (isChecked && count == 0) {
                          count = 1;
                          nhom1.text = member.name!;
                          widget.nnMatch.nhom['player1'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                          //Init data for single match
                          nhom2.text = member.name!;
                          widget.nnMatch.nhom['player2'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                        } else if (isChecked && count == 1) {
                          count = 2;
                          nhom2.text = member.name!;
                          widget.nnMatch.nhom['player2'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                        }
                      } else {
                        if (isChecked && count == 0) {
                          count = 1;
                          nhua1.text = member.name!;
                          widget.nnMatch.nhua['player1'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                          //Init data for single match
                          nhua2.text = member.name!;
                          widget.nnMatch.nhua['player2'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                        } else if (isChecked && count == 1) {
                          count = 2;
                          nhua2.text = member.name!;
                          widget.nnMatch.nhua['player2'] = mapMemberId.keys
                              .firstWhere((k) => mapMemberId[k] == member.name);
                        }
                      }
                    });
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  //replace with our own icon data.
                )),
            body: new ListView(
              children: selectedPlayers.keys.map((Member key) {
                return Center(
                  child: CheckboxListTile(
                    title: new Text(key.name!),
                    value: selectedPlayers[key],
                    onChanged: (value) {
                      setState(() {
                        selectedPlayers[key] = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          );
        });
      },
    );
  }

  void onSelectMemberNhomButton() {
    onSelectMemberButton(true);
  }

  void onSelectMemberNhuaButton() {
    onSelectMemberButton(false);
  }
}
