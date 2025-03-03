import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/utilities/date_formatter.dart';
import '../../../domain/entities/imsakiyah_entity.dart';
import '../../../domain/repositories/imsakiyah_repository.dart';
import '../../../domain/usecases/imsakiyah_usecases.dart';
import '../../../service_locator.dart';

class HomeProvider extends ChangeNotifier {
  final Ref ref;
  final ImsakiyahRepository imsakiyahRepository;

  HomeProvider({
    required this.ref,
    required this.imsakiyahRepository,
  });

  ImsakiyahEntity? imsakiyahEntity;

  Timer? timer;
  String? clock;

  void initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final time = DateTime.now().toIso8601String();
    clock = DateFormatter.clock(time);
    notifyListeners();
  }

  void getImsakiyah() async {
    final location = ref.read(locationProvider).locationEntity;
    if (location == null) return;

    final res = await GetImsakiyahScheduleUsecase(imsakiyahRepository).call(
      location,
    );

    imsakiyahEntity = res.data;
    notifyListeners();
  }

  String getTimePeriodName() {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return 'Pagi';
    } else if (hour >= 12 && hour < 16) {
      return 'Siang';
    } else if (hour >= 16 && hour < 19) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  Color getTimePeriodColor() {
    int hour = DateTime.now().hour;
    double opacity = 0.40;

    if (hour >= 6 && hour < 12) {
      return AppColors.morning.withOpacity(opacity);
    } else if (hour >= 12 && hour < 16) {
      return AppColors.day.withOpacity(opacity);
    } else if (hour >= 16 && hour < 19) {
      return AppColors.afternoon.withOpacity(opacity);
    } else {
      return AppColors.night.withOpacity(opacity);
    }
  }

  String getTimePeriodImage() {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return AppAssets.morning;
    } else if (hour >= 12 && hour < 16) {
      return AppAssets.day;
    } else if (hour >= 16 && hour < 19) {
      return AppAssets.afternoon;
    } else {
      return AppAssets.night;
    }
  }
}
