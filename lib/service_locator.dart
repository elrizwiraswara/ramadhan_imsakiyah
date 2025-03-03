import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/services/network/network_service.dart';
import 'data/datasources/imsakiyah_datasource.dart';
import 'data/datasources/location_datasource.dart';
import 'data/repositories/imsakiyah_repository_impl.dart';
import 'data/repositories/location_repository_impl.dart';
import 'domain/repositories/imsakiyah_repository.dart';
import 'domain/repositories/location_repository.dart';
import 'presentation/providers/home/home_provider.dart';
import 'presentation/providers/home/location_provider.dart';

// Services
final _networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

// Datasources
final _locationDatasourceProvider = Provider<LocationDatasource>((ref) {
  final networkService = ref.read(_networkServiceProvider);
  return LocationDatasource(networkService);
});

final _imsakiyahDatasourceProvider = Provider<ImsakiyahDatasource>((ref) {
  final networkService = ref.read(_networkServiceProvider);
  return ImsakiyahDatasource(networkService);
});

// Repositories
final _locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final locationDatasource = ref.read(_locationDatasourceProvider);
  return LocationRepositoryImpl(locationDatasource: locationDatasource);
});

final _imsakiyahRepositoryProvider = Provider<ImsakiyahRepository>((ref) {
  final imsakiyahDatasource = ref.read(_imsakiyahDatasourceProvider);
  return ImsakiyahRepositoryImpl(imsakiyahDatasource: imsakiyahDatasource);
});

// ChangeNotifiers
final locationProvider = ChangeNotifierProvider<LocationProvider>((ref) {
  final locationRepository = ref.read(_locationRepositoryProvider);

  return LocationProvider(
    ref: ref,
    locationRepository: locationRepository,
  );
});

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  final imsakiyahRepository = ref.read(_imsakiyahRepositoryProvider);

  return HomeProvider(
    ref: ref,
    imsakiyahRepository: imsakiyahRepository,
  );
});
