import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/dbHelper.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Penilaian.dart';
import 'dart:developer';

class InsertDataPage extends StatefulWidget {
  const InsertDataPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<InsertDataPage> createState() => _InsertDataPageState();
}

class _InsertDataPageState extends State<InsertDataPage> {
  final dbHelper = DatabaseHelper.instance;

  DateTime now = DateTime.now();
  String formattedDate = '';

  final namaController = TextEditingController();
  final jabatanController = TextEditingController();
  final lokasiController = TextEditingController();
  final keteranganController = TextEditingController();

  Map<String, List<DetailPenilaian>> listPenilaian = {
    "Kedisipinan": [
      DetailPenilaian(
          "Selama Kontrak {PKWT} Pernah Mangkir > 2 kali", false, DateTime(0)),
      DetailPenilaian(
          "Selama Kontrak {PKWT} Pernah Mangkir > 2 kali", false, DateTime(0))
    ],
    "TEST2": [
      DetailPenilaian("TEst1", false, DateTime(0)),
      DetailPenilaian("TEst2", false, DateTime(0))
    ],
    "TEST3": [
      DetailPenilaian("TEst1", false, DateTime(0)),
      DetailPenilaian("TEst2", false, DateTime(0))
    ],
    "TEST4": [
      DetailPenilaian("TEst1", false, DateTime(0)),
      DetailPenilaian("TEst2", false, DateTime(0))
    ],
    "TEST5": [
      DetailPenilaian("TEst1", false, DateTime(0)),
      DetailPenilaian("TEst2", false, DateTime(0))
    ]
  };

  @override
  void initState() {
    formattedDate = DateFormat('EE/d MMM yyyy').format(now);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    namaController.dispose();
    jabatanController.dispose();
    lokasiController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  void _insert(Penilaian data) async {
    // String encodeNilai = Penilaian.listPenelitianToString(listPenilaian);
    // log("data => $encodeNilai");
    // log("decode => ${(jsonDecode(encodeNilai) as Map<String, dynamic>)}");
    // var temp = Penilaian.fromDynamic(jsonDecode(encodeNilai));
    // log("decode file => ${temp.values.elementAt(0)[0].desc}");

    // row to insert
    // Map<String, dynamic> row = {
    //   DatabaseHelper.columnDateNow: data.dateNow,
    //   DatabaseHelper.columnName: data.name,
    //   DatabaseHelper.columnJabatan: data.jabatan,
    //   DatabaseHelper.columnLokasi: data.lokasi,
    //   DatabaseHelper.columnKeterangan: data.keterangan,
    //   DatabaseHelper.columnListPenilaian:
    //       Penilaian.listPenelitianToString(listPenilaian)
    //   // json.encode(data.listPenilaian)
    // };
    // Penilaian penilaian = Penilaian.fromMap(row);
    final id = await dbHelper.insert(data);
    Navigator.of(context).pop();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("$id inserted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(10),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             ListTile(
//               title: const Text("1"),
//               subtitle: TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8))),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Type your name here',
//                 ),
//               ),
//             ),
//             ListTile(
//               title: const Text("2"),
//               subtitle: TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8))),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Type your name here',
//                 ),
//               ),
//             ),
//             ListTile(
//               title: const Text("3"),
//               subtitle: TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8))),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Type your name here',
//                 ),
//               ),
//             ),
//             ListTile(
//               title: const Text("4"),
//               subtitle: TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8))),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Type your name here',
//                 ),
//               ),
//             ),
        // ListTile(
        //   title: const Text("5"),
        //   subtitle: TextFormField(
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(8))),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
        //       hintText: 'Type your name here',
        //     ),
        //   ),
        // ),
//             Text("ASDASD"),
//           ]),
//         ),
//       ),
//     );
//   }
// }
        body: NestedScrollView(
            // Setting floatHeaderSlivers to true is required in order to float
            // the outer slivers over the inner scrollable.
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  title: Text(widget.title),
                ),
              ];
            },
            body: Expanded(
                child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                  const Text(
                    "FORM Penilaian Kinerja Karyawan / Appraisal Performance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "PT.CobaCoba",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  CachedNetworkImage(
                    imageUrl: "http://via.placeholder.com/350x150",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Karyawan/Ti',
                            ),
                            controller: namaController,
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Jabatan/Posisi',
                            ),
                            controller: jabatanController,
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Dept/Lokasi Kerja',
                            ),
                            controller: lokasiController,
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Keterangan/Catatan',
                            ),
                            controller: keteranganController,
                          ))),
                  // Wrap(
                  //   children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: listPenilaian.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              listPenilaian.keys.elementAt(index),
                              textAlign: TextAlign.start,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listPenilaian.values
                                    .elementAt(index)
                                    .length,
                                itemBuilder: (context, indexDalem) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          flex: 7,
                                          child: Text(listPenilaian.values
                                              .elementAt(index)[indexDalem]
                                              .desc)),
                                      Expanded(
                                        child: Checkbox(
                                          value: listPenilaian.values
                                              .elementAt(index)[indexDalem]
                                              .isOk,
                                          onChanged: (value) {
                                            setState(() {
                                              listPenilaian.values
                                                  .elementAt(index)[indexDalem]
                                                  .isOk = value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            // child: TextFormField(
                                            //   initialValue: listPenilaian.values
                                            //       .elementAt(index)[indexDalem]
                                            //       .dateEvent,
                                            //   decoration: const InputDecoration(
                                            //     border: UnderlineInputBorder(),
                                            //     labelText: 'Date',
                                            //   ),
                                            //   onChanged: (value) {
                                            //     setState(() {
                                            // listPenilaian.values
                                            //     .elementAt(
                                            //         index)[indexDalem]
                                            //     .dateEvent = value;
                                            //     });
                                            //   },
                                            // )
                                            child: GestureDetector(
                                              onTap: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2099),
                                                ).then((date) {
                                                  //tambahkan setState dan panggil variabel _dateTime.
                                                  setState(() {
                                                    // _dateTime = date;
                                                    if (date != null) {
                                                      listPenilaian.values
                                                          .elementAt(
                                                              index)[indexDalem]
                                                          .dateEvent = date;
                                                    }
                                                  });
                                                });
                                              },
                                              child: Text(
                                                  DateFormat('EE/d MMM yyyy')
                                                      .format(listPenilaian
                                                          .values
                                                          .elementAt(
                                                              index)[indexDalem]
                                                          .dateEvent)),
                                            ),
                                          )),
                                    ],
                                  );
                                }),
                          ],
                        );
                      }),
                  // ],
                  // ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                          40), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {
                      Penilaian nilai = Penilaian(
                          0,
                          now,
                          namaController.text,
                          jabatanController.text,
                          lokasiController.text,
                          keteranganController.text,
                          listPenilaian);
                      _insert(nilai);
                      // var decodeNilai = Penilaian.fromMap(jsonDecode(encodeNilai));
                      // log("decode file => ${decodeNilai.listPenilaian.values.elementAt(0)}");
                      // _insert(
                      //   Penilaian(
                      //       0,
                      //       now,
                      //       namaController.text,
                      //       jabatanController.text,
                      //       lokasiController.text,
                      //       keteranganController.text,
                      //       listPenilaian),
                      // );
                      // Navigator.of(context).pushNamed('/data/show');

                      // Navigator.pop(
                      //     context,
                      //     // MaterialPageRoute(
                      //     //   builder: (context) => DataPage(
                      //     //       dataPenilaian: Penilaian(
                      //     //           0,
                      //     //           now,
                      //     //           namaController.text,
                      //     //           jabatanController.text,
                      //     //           lokasiController.text,
                      //     //           keteranganController.text,
                      //     //           listPenilaian)),
                      //     // ),
                      //     MaterialPageRoute(
                      //         builder: (context) => const DataPage(
                      //               idData: 0,
                      //             )));
                    },
                    child: const Text("Save"),
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: const [
                  //     Text("data"),
                  //     Spacer(),
                  //     Text("data"),
                  //   ],
                  // ),
                  // ListTile(
                  //   title: const Text("5"),
                  //   subtitle: TextFormField(
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8))),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       hintText: 'Type your name here',
                  //     ),
                  //   ),
                  // ),
                  // ListView.builder(
                  //     padding: const EdgeInsets.all(8),
                  //     itemCount: 50,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return SizedBox(
                  //         height: 50,
                  //         child: Center(child: Text('Item $index')),
                  //       );
                  //     }),
                ]))));
  }
}

    // body: NestedScrollView(
    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //     // These are the slivers that show up in the "outer" scroll view.
    //     return <Widget>[];
    //   },
    //   body: Column(
    //     children: [
    //       const Text(
    //         "FORM Penilaian Kinerja Karyawan / Appraisal Performance",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 24.0,
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       const Text(
    //         "PT.Bakri Karya Sarana",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 24.0,
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       CachedNetworkImage(
    //         imageUrl: "http://via.placeholder.com/350x150",
    //         placeholder: (context, url) =>
    //             const CircularProgressIndicator(),
    //         errorWidget: (context, url, error) => const Icon(Icons.error),
    //       ),
    //       Text(
    //         formattedDate,
    //         textAlign: TextAlign.start,
    //         style: const TextStyle(
    //             fontSize: 24.0,
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       Expanded(
    //           child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: TextFormField(
    //                 decoration: const InputDecoration(
    //                   border: UnderlineInputBorder(),
    //                   labelText: 'Karyawan/Ti',
    //                 ),
    //                 controller: karyawanController,
    //               ))),
    //       Expanded(
    //           child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: TextFormField(
    //                 decoration: const InputDecoration(
    //                   border: UnderlineInputBorder(),
    //                   labelText: 'Jabatan/Posisi',
    //                 ),
    //                 controller: karyawanController,
    //               ))),
    //       Expanded(
    //           child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: TextFormField(
    //                 decoration: const InputDecoration(
    //                   border: UnderlineInputBorder(),
    //                   labelText: 'Dept/Lokasi Kerja',
    //                 ),
    //                 controller: karyawanController,
    //               ))),
    //       Row(
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           const Text("data"),
    //           Spacer(),
    //           const Text("data"),
    //         ],
    //       ),
    //     ],
    //   ),
    // ));
//   }
// }

// Column(
//           children: [
//             const Text(
//               "FORM Penilaian Kinerja Karyawan / Appraisal Performance",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 24.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               "PT.Bakri Karya Sarana",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 24.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             CachedNetworkImage(
//               imageUrl: "http://via.placeholder.com/350x150",
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//             ),
//             Text(
//               formattedDate,
//               textAlign: TextAlign.start,
//               style: const TextStyle(
//                   fontSize: 24.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//                 child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Karyawan/Ti',
//                       ),
//                       controller: karyawanController,
//                     ))),
//             Expanded(
//                 child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Karyawan/Ti',
//                       ),
//                       controller: karyawanController,
//                     ))),
//             Expanded(
//                 child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Karyawan/Ti',
//                       ),
//                       controller: karyawanController,
//                     ))),
//           ],
//         )
