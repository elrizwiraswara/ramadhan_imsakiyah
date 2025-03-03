import '../../core/usecase/result.dart';
import '../../domain/entities/imsakiyah_entity.dart';
import '../../domain/repositories/imsakiyah_repository.dart';
import '../datasources/imsakiyah_datasource.dart';

class ImsakiyahRepositoryImpl extends ImsakiyahRepository {
  final ImsakiyahDatasource imsakiyahDatasource;

  ImsakiyahRepositoryImpl({required this.imsakiyahDatasource});

  @override
  Future<Result<ImsakiyahEntity>> getImsakiyahSchedule({
    required String province,
    required String city,
  }) async {
    try {
      final res = await imsakiyahDatasource.getImsakiyahSchedule(
        province: province,
        city: city,
      );

      if (res.status == Status.ok) {
        return Result.ok(data: res.data?.toEntity());
      } else {
        return Result.error(statusCode: res.statusCode, message: res.message);
      }
    } catch (e) {
      return Result.error(message: e.toString());
    }
  }
}
