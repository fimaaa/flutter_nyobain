import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dbHelper.dart';

class Penilaian {
  late int id;
  late DateTime dateNow;
  late String name;
  late String jabatan;
  late String lokasi;
  late String keterangan;
  late Map<String, List<DetailPenilaian>> listPenilaian;

  Penilaian(this.id, this.dateNow, this.name, this.jabatan, this.lokasi,
      this.keterangan, this.listPenilaian);

  Penilaian.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dateNow = DateTime.parse(map['dateNow']);
    name = map['name'];
    jabatan = map['jabatan'];
    lokasi = map['lokasi'];
    keterangan = map['keterangan'];
    listPenilaian = fromDynamic(jsonDecode(map['listPenilaian']));
  }

  static HashMap<String, List<DetailPenilaian>> fromDynamic(dynamic value) {
    HashMap<String, List<DetailPenilaian>> temp = HashMap();
    (value as Map<String, dynamic>).forEach((key, value) {
      List<DetailPenilaian> childTemp = [];
      for (var element in (value as List<dynamic>)) {
        childTemp.add(DetailPenilaian.fromMap(element));
      }
      temp[key] = childTemp;
    });
    return temp;
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnDateNow: dateNow,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnJabatan: jabatan,
      DatabaseHelper.columnLokasi: lokasi,
      DatabaseHelper.columnKeterangan: keterangan,
      DatabaseHelper.columnListPenilaian: json.encode(listPenilaian)
    };
  }

  @override
  String toString() {
    // String temp = "";
    // listPenilaian.forEach((key, value) {
    //   temp += '"$key": ${value.toString()}';
    // });
    String temp = listPenelitianToString(listPenilaian);
    // temp += "";
    return '{"id":$id,"dateNow":"$dateNow","name":"$name","jabatan":"$jabatan","lokasi":"$lokasi","keterangan":"$keterangan","listPenilaian":{$temp}}';
  }

  static String listPenelitianToString(
      Map<String, List<DetailPenilaian>> value) {
    String temp = "";
    value.forEach((key, element) {
      temp += '"$key": ${element.toString()}';

      if (value.keys.elementAt(value.length - 1) != key) {
        temp += ",";
      }
    });
    return "{$temp}";
  }

  // const Penilaian(this.dateNow, this.name, this.jabatan, this.lokasi,);
}

class DetailPenilaian {
  late String desc;
  late bool isOk;
  late DateTime dateEvent;

  DetailPenilaian(this.desc, this.isOk, this.dateEvent);

  @override
  String toString() {
    return '{"desc":"$desc","isOk":$isOk,"dateEvent":"$dateEvent"}';
  }

  DetailPenilaian.fromMap(Map<String, dynamic> map) {
    desc = map["desc"];
    isOk = map["isOk"];
    dateEvent = DateTime.parse(map["dateEvent"]);
  }
}
