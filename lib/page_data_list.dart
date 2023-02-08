import 'package:flutter/material.dart';
import 'package:flutter_application_1/Penilaian.dart';
import 'package:flutter_application_1/page_data_insert.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'dbHelper.dart';

class ListDataPage extends StatefulWidget {
  const ListDataPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ListDataPage> createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Penilaian> listDataPenilaian = [];

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    listDataPenilaian.clear();
    allRows.forEach((row) => listDataPenilaian.add(Penilaian.fromMap(row)));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Query done.")));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _queryAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const Text('Snapping Nested SliverAppBar'),
              floating: true,
              snap: true,
              expandedHeight: 200.0,
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      }, body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
              child: CustomScrollView(
                // The "controller" and "primary" members should be left unset, so that
                // the NestedScrollView can control this inner scroll view.
                // If the "controller" property is set, then this scroll view will not
                // be associated with the NestedScrollView.
                slivers: <Widget>[
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverFixedExtentList(
                    itemExtent: 48.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => ListTile(
                        title: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/data/show',
                                arguments: listDataPenilaian[index].id,
                              );
                            },
                            child: Text(
                                '${listDataPenilaian[index].id} - ${listDataPenilaian[index].name} [${DateFormat('EE/d MMM yyyy').format(listDataPenilaian[index].dateNow)}]')),
                      ),
                      childCount: listDataPenilaian.length,
                    ),
                  ),
                ],
              ),
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  _queryAll();
                });
              });
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InsertDataPage(
                      title: "InserDataPage",
                    )),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
