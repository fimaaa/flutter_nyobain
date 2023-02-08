import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'Penilaian.dart';
import 'dbHelper.dart';
import 'dart:developer';

class DataPage extends StatefulWidget {
  const DataPage({super.key, required this.idData});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final int idData;

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final dbHelper = DatabaseHelper.instance;
  Penilaian? dataPenilaian;

  void _getData() async {
    var listDataPenilaian = await dbHelper.queryRow(widget.idData);
    log("LISTDATA = $listDataPenilaian");
    if (listDataPenilaian.length > 0) {
      dataPenilaian = Penilaian.fromMap(listDataPenilaian[0]);
    }
    // final allRows = await dbHelper.queryAllRows();
    // allRows.forEach((row) => listDataPenilaian.add(Penilaian.fromMap(row)));
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Query done.")));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    log("INITSTATE");
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Data Page"),
      // ),
      // body: Expanded(
      // body: NestedScrollView(
      //   // Setting floatHeaderSlivers to true is required in order to float
      //   // the outer slivers over the inner scrollable.
      //   floatHeaderSlivers: true,
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return <Widget>[];
      //   },

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              pinned: true,
              title: Text('Data Page'),
            ),
          ];
        },
        // body: Column(
        //   children: <Widget>[
        //     const FlutterLogo(size: 100.0, textColor: Colors.purple),
        //     SizedBox(
        //       height: 300.0,
        //       child: ListView.builder(
        //         itemCount: 60,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Text('Item $index');
        //         },
        //       ),
        //     ),
        //     const FlutterLogo(size: 100.0, textColor: Colors.orange),
        //   ],
        // ),

        body: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            "FORM Penilaian Kinerja Karyawan / Appraisal Performance",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            "PT.Cobacoba",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/350x150",
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            DateFormat('EE/d MMM')
                .format(dataPenilaian?.dateNow ?? DateTime(0)),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          Text(
            (dataPenilaian?.name ?? "-"),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          Text(
            dataPenilaian?.jabatan ?? "-",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          Text(
            dataPenilaian?.lokasi ?? "-",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: dataPenilaian?.listPenilaian.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Text(dataPenilaian?.listPenilaian.keys.elementAt(index) ??
                          "-"),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: dataPenilaian?.listPenilaian.values
                                  .elementAt(index)
                                  .length ??
                              0,
                          itemBuilder: (context, childIndex) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: Text(dataPenilaian
                                            ?.listPenilaian.values
                                            .elementAt(index)[childIndex]
                                            .desc ??
                                        "-")),
                                Expanded(
                                    child: Text((dataPenilaian
                                                ?.listPenilaian.values
                                                .elementAt(index)[childIndex]
                                                .isOk ??
                                            false)
                                        .toString())),
                                Expanded(
                                    child: Text((dataPenilaian
                                                ?.listPenilaian.values
                                                .elementAt(index)[childIndex]
                                                .dateEvent ??
                                            DateTime(0))
                                        .toString())),
                              ],
                            );
                          })
                    ]);
                  }))
        ]),
      ),
    );
  }
}
