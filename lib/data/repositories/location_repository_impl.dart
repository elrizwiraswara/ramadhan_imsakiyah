import '../../core/usecase/result.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_datasource.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationDatasource locationDatasource;

  LocationRepositoryImpl({required this.locationDatasource});

  @override
  Future<Result<List<String>>> getProvinces() async {
    try {
      final res = await locationDatasource.getProvinces();

      if (res.status == Status.ok) {
        return Result.ok(data: res.data);
      } else {
        return Result.error(statusCode: res.statusCode, message: res.message);
      }
    } catch (e) {
      return Result.error(message: e.toString());
    }
  }

  @override
  Future<Result<List<String>>> getCities(String province) async {
    try {
      final res = await locationDatasource.getCities(province);

      if (res.status == Status.ok) {
        return Result.ok(data: res.data);
      } else {
        return Result.error(statusCode: res.statusCode, message: res.message);
      }
    } catch (e) {
      return Result.error(message: e.toString());
    }
  }
}
