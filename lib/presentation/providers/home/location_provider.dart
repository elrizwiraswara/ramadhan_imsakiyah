import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/constants/app_constant.dart';
import '../../../app/services/preferences/prefs_service.dart';
import '../../../app/utilities/console_log.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/repositories/location_repository.dart';
import '../../../domain/usecases/location_usecases.dart';
import '../../../domain/usecases/params/no_params.dart';

class LocationProvider extends ChangeNotifier {
  final Ref ref;
  final LocationRepository locationRepository;

  LocationProvider({
    required this.ref,
    required this.locationRepository,
  });

  LocationEntity? locationEntity;

  List<String> provinces = [];
  String? selectedProvice;

  List<String> cities = [];
  String? selectedCity;

  void submitLocation() {
    locationEntity = LocationEntity(
      province: selectedProvice!,
      city: selectedCity!,
    );
    notifyListeners();
    _saveUserLocation();
  }

  Future<LocationEntity?> loadSavedUserLocation() async {
    final data = await PrefsService.getString(AppConstant.userLocationKey);
    if (data == null) return null;

    final decoded = jsonDecode(data);

    locationEntity = LocationEntity(
      province: decoded['province'],
      city: decoded['city'],
    );

    notifyListeners();

    return locationEntity;
  }

  void _saveUserLocation() async {
    if (locationEntity == null) return;

    final data = {
      'province': locationEntity?.province,
      'city': locationEntity?.city,
    };

    await PrefsService.setString(
      AppConstant.userLocationKey,
      jsonEncode(data),
    );

    cl('data $data');
  }

  void getProvinces() async {
    final res = await GetProvinceUsecase(locationRepository).call(NoParams());

    provinces = res.data ?? [];
    notifyListeners();
  }

  void getCities() async {
    if (selectedProvice == null) return;

    final res = await GetCitiesUsecase(locationRepository).call(
      selectedProvice!,
    );

    cities = res.data ?? [];
    notifyListeners();
  }

  void onChangeProvince(String value) {
    selectedProvice = value;
    selectedCity = null;
    notifyListeners();
    getCities();
  }

  void onChangeCity(String value) {
    selectedCity = value;
    notifyListeners();
  }

  bool isFormValid() {
    final validator = [
      selectedProvice != null,
      selectedCity != null,
    ];

    return !validator.contains(false);
  }
}
