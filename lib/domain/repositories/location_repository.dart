import '../../core/usecase/result.dart';

abstract class LocationRepository {
  Future<Result<List<String>>> getProvinces();

  Future<Result<List<String>>> getCities(String city);
}
