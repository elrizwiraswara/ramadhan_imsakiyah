import '../../app/services/network/network_service.dart';
import '../../core/usecase/result.dart';
import '../models/imsakiyah_model.dart';

class ImsakiyahDatasource {
  final NetworkService _networkService;

  ImsakiyahDatasource(this._networkService);

  Future<Result<ImsakiyahModel>> getImsakiyahSchedule({
    required String province,
    required String city,
  }) async {
    return await _networkService.sendRequest<ImsakiyahModel>(
      endpoint: '/imsakiyah',
      method: HttpMethod.POST,
      authRequired: false,
      data: {'provinsi': province, 'kabkota': city},
      parser: (json) => ImsakiyahModel.fromJson(json[0]),
    );
  }
}
