import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int? id;
  final String province;
  final String city;

  const LocationEntity({
    this.id,
    required this.province,
    required this.city,
  });

  LocationEntity copyWith({
    int? id,
    String? province,
    String? city,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      province: province ?? this.province,
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props => [
        id,
        province,
        city,
      ];
}
