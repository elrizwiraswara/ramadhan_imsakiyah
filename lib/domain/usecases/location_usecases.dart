import '../../core/usecase/result.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/location_repository.dart';
import 'params/no_params.dart';

class GetProvinceUsecase extends UseCase<Result, NoParams> {
  GetProvinceUsecase(this._locationRepository);

  final LocationRepository _locationRepository;

  @override
  Future<Result<List<String>>> call(NoParams params) async =>
      _locationRepository.getProvinces();
}

class GetCitiesUsecase extends UseCase<Result, String> {
  GetCitiesUsecase(this._locationRepository);

  final LocationRepository _locationRepository;

  @override
  Future<Result<List<String>>> call(String params) async =>
      _locationRepository.getCities(params);
}
