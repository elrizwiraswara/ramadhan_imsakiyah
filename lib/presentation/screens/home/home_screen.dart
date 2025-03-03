import 'package:app_image/app_image.dart';
import 'package:app_table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_sizes.dart';
import '../../../app/themes/app_theme.dart';
import '../../../app/utilities/date_formatter.dart';
import '../../../service_locator.dart';
import 'components/location_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(homeProvider).initTimer();

      final location = await ref.read(locationProvider).loadSavedUserLocation();

      if (location == null) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const LocationDialog();
          },
        );
      }

      ref.read(homeProvider).getImsakiyah();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider).locationEntity;
    final imsakiyahEntity = ref.watch(homeProvider).imsakiyahEntity;

    if (location == null || imsakiyahEntity == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _table(),
          _header(),
        ],
      ),
    );
  }

  Widget _header() {
    final image = ref.watch(homeProvider).getTimePeriodImage();

    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          AppImage(
            image: image,
            fit: BoxFit.cover,
            width: AppSizes.screenWidth(context),
            height: 160,
          ),
          Positioned(
            bottom: 20,
            child: _headerGradient(),
          ),
          Positioned(
            top: 50,
            left: AppSizes.margin,
            child: _headerTitle(),
          ),
          Positioned(
            top: 80,
            child: _headerCard(),
          ),
        ],
      ),
    );
  }

  Widget _headerTitle() {
    final time = ref.watch(homeProvider).getTimePeriodName();

    return Text(
      'Selamat ${time}!',
      style: AppTheme.text(context).titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        shadows: [
          Shadow(
            color: AppColors.black.withOpacity(0.18),
            blurRadius: 1,
            offset: const Offset(1, 2),
          )
        ],
      ),
    );
  }

  Widget _headerGradient() {
    return Container(
      width: AppSizes.screenWidth(context),
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x00FFFFFF),
            Colors.white,
            Colors.white,
            Color(0x00FFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _headerCard() {
    return SizedBox(
      width: AppSizes.screenWidth(context),
      child: Container(
        margin: const EdgeInsets.all(AppSizes.margin),
        padding: const EdgeInsets.all(AppSizes.padding),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppTheme.color(context).onPrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.radius),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.10),
              blurRadius: 2,
              offset: const Offset(1, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _locationInfo()),
            _dateAndTime(),
          ],
        ),
      ),
    );
  }

  Widget _locationInfo() {
    final location = ref.watch(locationProvider).locationEntity;

    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return const LocationDialog();
          },
        );

        ref.read(homeProvider).getImsakiyah();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  location?.city ?? '-',
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.text(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.color(context).onSurface,
                      ),
                ),
              ),
              const SizedBox(width: AppSizes.margin / 5),
              const Icon(
                Icons.edit_outlined,
                size: 14,
              )
            ],
          ),
          Text(
            location?.province ?? '-',
            overflow: TextOverflow.ellipsis,
            style: AppTheme.text(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.color(context).onSurface,
                ),
          ),
        ],
      ),
    );
  }

  Widget _dateAndTime() {
    final clock = ref.watch(homeProvider).clock;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormatter.normal(DateTime.now().toIso8601String()),
          style: AppTheme.text(context).bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.color(context).onSurface,
              ),
        ),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 14,
            ),
            const SizedBox(width: AppSizes.margin / 5),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              ),
              child: Text(
                clock ?? '-:-:-',
                style: AppTheme.text(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.color(context).onSurface,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _table() {
    final imsakiyah = ref.watch(homeProvider).imsakiyahEntity?.imsakiyah;
    final color = ref.watch(homeProvider).getTimePeriodColor();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding).copyWith(top: 200),
      child: AppTable(
        headerBackgroundColor: color,
        backgroundColor: AppTheme.color(context).surfaceContainerLowest,
        dataBottomBorderWidth: 1,
        headerBottomBorderWidth: 1,
        dataBottomBorderColor: AppTheme.color(context).surfaceDim,
        headerBottomBorderColor: AppTheme.color(context).surfaceDim,
        borderRadius: AppSizes.radius,
        tableBorderWidth: 1,
        tableBorderColor: AppTheme.color(context).surfaceDim,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSizes.padding / 2),
        minWidth: 600,
        headerData: [
          TableModel(
            data: 'Tanggal',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Imsak',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Subuh',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Terbit',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Dhuha',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Dzuhur',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Ashar',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Maghrib',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TableModel(
            data: 'Isya',
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
        data: (imsakiyah?.isNotEmpty ?? false)
            ? List.generate(imsakiyah!.length, (index) {
                Color? rowColor = index.isEven
                    ? AppTheme.color(context).surfaceContainer
                    : null;

                bool isNow = imsakiyah[index].tanggal == DateTime.now().day;

                FontWeight weight = isNow ? FontWeight.bold : FontWeight.normal;

                final textStyle = Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: weight);

                return [
                  TableModel(
                    data: '${imsakiyah[index].tanggal}',
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].imsak,
                    color: color,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].subuh,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].terbit,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].dhuha,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].dzuhur,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].ashar,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].maghrib,
                    color: color,
                    textStyle: textStyle,
                  ),
                  TableModel(
                    data: imsakiyah[index].isya,
                    color: rowColor,
                    textStyle: textStyle,
                  ),
                ];
              })
            : [
                [TableModel(data: '(Empty)')]
              ],
      ),
    );
  }
}
