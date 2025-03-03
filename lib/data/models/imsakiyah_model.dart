import '../../domain/entities/imsakiyah_entity.dart';

class ImsakiyahModel {
  String? provinsi;
  String? kabkota;
  String? hijriah;
  String? masehi;
  List<ImsakiyahScheduleModel>? imsakiyah;

  ImsakiyahModel({
    this.provinsi,
    this.kabkota,
    this.hijriah,
    this.masehi,
    this.imsakiyah,
  });

  factory ImsakiyahModel.fromJson(Map<String, dynamic> json) => ImsakiyahModel(
        provinsi: json['provinsi'],
        kabkota: json['kabkota'],
        hijriah: json['hijriah'],
        masehi: json['masehi'],
        imsakiyah: json['imsakiyah'] == null
            ? []
            : List<ImsakiyahScheduleModel>.from(json['imsakiyah']!
                .map((x) => ImsakiyahScheduleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'provinsi': provinsi,
        'kabkota': kabkota,
        'hijriah': hijriah,
        'masehi': masehi,
        'imsakiyah': imsakiyah == null
            ? []
            : List<dynamic>.from(imsakiyah!.map((x) => x.toJson())),
      };

  static ImsakiyahModel fromEntity(ImsakiyahEntity entity) => ImsakiyahModel(
        provinsi: entity.provinsi,
        kabkota: entity.kabkota,
        hijriah: entity.hijriah,
        masehi: entity.masehi,
        imsakiyah: entity.imsakiyah
            ?.map((schedule) => ImsakiyahScheduleModel.fromEntity(schedule))
            .toList(),
      );

  ImsakiyahEntity toEntity() => ImsakiyahEntity(
        provinsi: provinsi,
        kabkota: kabkota,
        hijriah: hijriah,
        masehi: masehi,
        imsakiyah: imsakiyah?.map((schedule) => schedule.toEntity()).toList(),
      );
}

class ImsakiyahScheduleModel {
  int? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;

  ImsakiyahScheduleModel({
    this.tanggal,
    this.imsak,
    this.subuh,
    this.terbit,
    this.dhuha,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
  });

  factory ImsakiyahScheduleModel.fromJson(Map<String, dynamic> json) =>
      ImsakiyahScheduleModel(
        tanggal: json['tanggal'],
        imsak: json['imsak'],
        subuh: json['subuh'],
        terbit: json['terbit'],
        dhuha: json['dhuha'],
        dzuhur: json['dzuhur'],
        ashar: json['ashar'],
        maghrib: json['maghrib'],
        isya: json['isya'],
      );

  Map<String, dynamic> toJson() => {
        'tanggal': tanggal,
        'imsak': imsak,
        'subuh': subuh,
        'terbit': terbit,
        'dhuha': dhuha,
        'dzuhur': dzuhur,
        'ashar': ashar,
        'maghrib': maghrib,
        'isya': isya,
      };

  static ImsakiyahScheduleModel fromEntity(ImsakiyahScheduleEntity entity) =>
      ImsakiyahScheduleModel(
        tanggal: entity.tanggal,
        imsak: entity.imsak,
        subuh: entity.subuh,
        terbit: entity.terbit,
        dhuha: entity.dhuha,
        dzuhur: entity.dzuhur,
        ashar: entity.ashar,
        maghrib: entity.maghrib,
        isya: entity.isya,
      );

  ImsakiyahScheduleEntity toEntity() => ImsakiyahScheduleEntity(
        tanggal: tanggal,
        imsak: imsak,
        subuh: subuh,
        terbit: terbit,
        dhuha: dhuha,
        dzuhur: dzuhur,
        ashar: ashar,
        maghrib: maghrib,
        isya: isya,
      );
}
