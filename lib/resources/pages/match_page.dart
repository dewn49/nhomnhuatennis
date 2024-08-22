import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/pages/match_view_page.dart';
import 'package:flutter_app/resources/widgets/match_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '/app/controllers/match_controller.dart';

class MatchPage extends NyStatefulWidget<MatchController> {
  static const path = '/match';

  MatchPage({super.key}) : super(path, child: () => _MatchPageState());
}

class Employee {
  final String id;
  final String name;
  final String role;
  final String email;
  Employee(
      {required this.id,
      required this.name,
      required this.role,
      required this.email});
  static get getEmployees {
    return [
      Employee(id: '1', name: 'Minh Innova', role: '0', email: '2'),
      Employee(id: '2', name: 'Quân ND', role: '0', email: '2'),
      Employee(id: '3', name: 'Tuấn CX', role: '0', email: '2'),
      Employee(id: '4', name: 'Trường VX', role: '0', email: '2'),
      Employee(id: '5', name: 'Sơn LT', role: '0', email: '1'),
      Employee(id: '6', name: 'John Doe', role: '0', email: '1'),
      Employee(id: '7', name: 'Jane Smith', role: '0', email: '0'),
      Employee(id: '8', name: 'Mike Johnson', role: '0', email: '0'),
      Employee(id: '9', name: 'Emily Brown', role: '0', email: '0'),
      Employee(id: '10', name: 'Alex Lee', role: '0', email: '0'),
    ];
  }
}

class _MatchPageState extends NyState<MatchPage>
    with SingleTickerProviderStateMixin {
  _MatchPageState() {
    // widget.controller.state = 'match_page';
    stateName = 'match_page';
  }

  final List<Employee> employees = Employee.getEmployees;

  late TabController _tabController;
  static List<Tab> myTabs = <Tab>[
    Tab(text: 'Trận đấu'),
    Tab(text: 'Thống kê'),
  ];

  /// [MatchController] controller
  MatchController get controller => widget.controller;

  @override
  init() async {
    _tabController = TabController(vsync: this, length: myTabs.length);
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
                'Ngày ',
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
          SizedBox(height: 10),
          Text('Tổng số trận: ' + listMatch.length.toString()),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
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
              child: Column(
                children: [
                  TabBar(
                    // indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                    labelColor: Color.fromARGB(255, 0, 106, 255),
                    labelStyle: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    unselectedLabelColor: Color(0xffA8A8A8),
                    unselectedLabelStyle: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA8A8A8),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    controller: _tabController,
                    tabs: myTabs.map((e) => e).toList(),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        NyListView.separated(
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
                        Center(
                          child: TableView.builder(
                            columnCount: 7,
                            rowCount: nnMatchStat.length + 1,
                            columnBuilder: buildTableSpanColumn,
                            rowBuilder: buildTableSpanRow,
                            cellBuilder:
                                (BuildContext context, TableVicinity vicinity) {
                              return TableViewCell(
                                  child: Center(child: addText(vicinity)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  TableSpan buildTableSpanRow(int index) {
    TableSpanDecoration foreGroundDecoration = const TableSpanDecoration(
        border: TableSpanBorder(
            trailing: BorderSide(color: Colors.black),
            leading: BorderSide(color: Colors.black)));
    TableSpanDecoration backGroundDecoration = TableSpanDecoration(
      color: index == 0 ? Color.fromARGB(255, 250, 252, 167) : null,
    );
    if (index == 0)
      return TableSpan(
          extent: const FixedTableSpanExtent(60),
          backgroundDecoration: backGroundDecoration,
          foregroundDecoration: foreGroundDecoration);

    return TableSpan(
        extent: const FixedTableSpanExtent(30),
        backgroundDecoration: backGroundDecoration,
        foregroundDecoration: foreGroundDecoration);
  }

  TableSpan buildTableSpanColumn(int index) {
    // TableSpanExtent extent1 = FixedTableSpanExtent(30);
    // TableSpanExtent extent2 = FixedTableSpanExtent(30);
    // double combiner(double value1, double value2) {
    //   return value1 + value2;
    // }

    TableSpanDecoration foreGroundDecoration = const TableSpanDecoration(
        border: TableSpanBorder(
            trailing: BorderSide(color: Colors.black),
            leading: BorderSide(color: Colors.black)));
    TableSpanDecoration backGroundDecoration = TableSpanDecoration(
      color: index == 0 ? Color.fromARGB(255, 250, 252, 167) : null,
    );
    // if (index == 1) {
    //   return TableSpan(
    //       extent: CombiningTableSpanExtent(extent1, extent2, combiner),
    //       backgroundDecoration: backGroundDecoration,
    //       foregroundDecoration: foreGroundDecoration);
    // }
    // return TableSpan(
    //     extent: const FixedTableSpanExtent(30),
    //     backgroundDecoration: backGroundDecoration,
    //     foregroundDecoration: foreGroundDecoration);

////////////////////////////////////////////

    TableSpanDecoration decoration = const TableSpanDecoration(
        border: TableSpanBorder(
            trailing: BorderSide(color: Colors.black),
            leading: BorderSide(color: Colors.black)));
    if (index == 0) {
      return TableSpan(
        extent: const FixedTableSpanExtent(30),
        backgroundDecoration: backGroundDecoration,
        foregroundDecoration: foreGroundDecoration,
      );
    } else if (index == 1) {
      return TableSpan(
        extent: const FixedTableSpanExtent(150),
        backgroundDecoration: decoration,
      );
    }
    // else if (index == 3) {
    //   return TableSpan(
    //     extent: const FractionalTableSpanExtent(0.1),
    //     backgroundDecoration: decoration,
    //   );
    // }
    return TableSpan(
        extent: const FractionalTableSpanExtent(0.1),
        backgroundDecoration: decoration);
  }

  static int NN_COL_STT = 0;
  static int NN_COL_NAME = 1;
  static int NN_COL_WIN = 2;
  static int NN_COL_TIE = 3;
  static int NN_COL_LOS = 4;
  static int NN_COL_DEUCE = 5;
  static int NN_COL_POINT = 6;

  Widget addText(TableVicinity vicinity) {
    if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_STT) {
      return Text("STT");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_NAME) {
      return Text("Cao thủ nhôm nhựa");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_WIN) {
      return Text("Thắng (Win)");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_TIE) {
      return Text("Hòa (Tie)");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_LOS) {
      return Text("Thua (Los)");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_DEUCE) {
      return Text("Điểm Deuce");
    } else if (vicinity.yIndex == 0 && vicinity.xIndex == NN_COL_POINT) {
      return Text("Điểm trận");
    } else {
      int player = nnMatchStat.keys.elementAt(vicinity.yIndex - 1);
      List<int> stats = nnMatchStat.values.elementAt(vicinity.yIndex - 1);

      if (vicinity.xIndex == NN_COL_STT) {
        return Text(vicinity.yIndex.toString());
      } else if (vicinity.xIndex == NN_COL_NAME) {
        return Text(mapMemberId[player]!);
      } else if (vicinity.xIndex == NN_COL_WIN) {
        return Text(stats[NN_STAT_WIN].toString());
      } else if (vicinity.xIndex == NN_COL_TIE) {
        return Text(stats[NN_STAT_TIE].toString());
      } else if (vicinity.xIndex == NN_COL_LOS) {
        return Text(stats[NN_STAT_LOS].toString());
      } else if (vicinity.xIndex == NN_COL_POINT) {
        return Text(stats[NN_STAT_POINT].toString());
      } else if (vicinity.xIndex == NN_COL_DEUCE) {
        return Text(stats[NN_STAT_DEU].toString());
      }
    }
    return Text("");
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
