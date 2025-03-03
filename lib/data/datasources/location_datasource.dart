import '../../app/services/network/network_service.dart';
import '../../core/usecase/result.dart';

class LocationDatasource {
  final NetworkService _networkService;

  LocationDatasource(this._networkService);

  Future<Result<List<String>>> getProvinces() async {
    return await _networkService.sendRequest<List<String>>(
      endpoint: '/imsakiyah/provinsi',
      method: HttpMethod.GET,
      authRequired: false,
      parser: (json) => List<String>.from(json),
    );
  }

  Future<Result<List<String>>> getCities(String province) async {
    return await _networkService.sendRequest<List<String>>(
      endpoint: '/imsakiyah/kabkota',
      method: HttpMethod.POST,
      authRequired: false,
      data: {'provinsi': province},
      parser: (json) => List<String>.from(json),
    );
  }
}
