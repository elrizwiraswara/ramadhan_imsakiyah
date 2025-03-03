import 'package:equatable/equatable.dart';

class ImsakiyahEntity extends Equatable {
  final String? provinsi;
  final String? kabkota;
  final String? hijriah;
  final String? masehi;
  final List<ImsakiyahScheduleEntity>? imsakiyah;

  const ImsakiyahEntity({
    this.provinsi,
    this.kabkota,
    this.hijriah,
    this.masehi,
    this.imsakiyah,
  });

  @override
  List<Object?> get props => [provinsi, kabkota, hijriah, masehi, imsakiyah];
}

class ImsakiyahScheduleEntity extends Equatable {
  final int? tanggal;
  final String? imsak;
  final String? subuh;
  final String? terbit;
  final String? dhuha;
  final String? dzuhur;
  final String? ashar;
  final String? maghrib;
  final String? isya;

  const ImsakiyahScheduleEntity({
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

  @override
  List<Object?> get props => [
        tanggal,
        imsak,
        subuh,
        terbit,
        dhuha,
        dzuhur,
        ashar,
        maghrib,
        isya,
      ];
}
