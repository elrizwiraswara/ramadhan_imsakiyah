import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/themes/app_sizes.dart';
import '../../../../app/themes/app_theme.dart';
import '../../../../service_locator.dart';
import '../../../widgets/app_button.dart';

class LocationDialog extends ConsumerStatefulWidget {
  const LocationDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationDialogState();
}

class _LocationDialogState extends ConsumerState<LocationDialog> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider).getProvinces();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provinces = ref.watch(locationProvider).provinces;

    return Dialog(
      backgroundColor: AppTheme.color(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: provinces.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _title(),
                  const SizedBox(height: AppSizes.margin),
                  _provinceField(),
                  const SizedBox(height: AppSizes.margin),
                  _cityField(),
                  const SizedBox(height: AppSizes.margin),
                  _submitButton(),
                ],
              )
            : const SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Tentukan Lokasi',
      style: AppTheme.text(context).titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _provinceField() {
    final provinces = ref.watch(locationProvider).provinces;
    final selectedProvince = ref.watch(locationProvider).selectedProvice;

    return DropdownButton(
      value: selectedProvince,
      isExpanded: true,
      hint: Text(
        'Pilih provinsi',
        style: AppTheme.text(context).bodyMedium,
      ),
      items: provinces.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: AppTheme.text(context).bodyMedium,
          ),
        );
      }).toList(),
      onChanged: (val) {
        if (val == null) return;
        ref.read(locationProvider).onChangeProvince(val);
      },
    );
  }

  Widget _cityField() {
    final cities = ref.watch(locationProvider).cities;
    final selectedCity = ref.watch(locationProvider).selectedCity;
    final selectedProvince = ref.watch(locationProvider).selectedProvice;

    return Stack(
      children: [
        DropdownButton(
          value: selectedCity,
          isExpanded: true,
          hint: Text(
            'Pilih kota',
            style: AppTheme.text(context).bodyMedium,
          ),
          items: cities.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: AppTheme.text(context).bodyMedium,
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val == null) return;
            ref.read(locationProvider).onChangeCity(val);
          },
        ),
        if (selectedProvince == null)
          Positioned.fill(
            child: Container(color: Colors.white54),
          ),
      ],
    );
  }

  Widget _submitButton() {
    final isFormValid = ref.watch(locationProvider).isFormValid();

    return AppButton(
      text: 'Submit',
      enabled: isFormValid,
      onTap: () {
        ref.read(locationProvider).submitLocation();
        context.pop();
      },
    );
  }
}
