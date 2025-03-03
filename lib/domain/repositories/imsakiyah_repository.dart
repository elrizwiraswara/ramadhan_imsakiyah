import '../../core/usecase/result.dart';
import '../entities/imsakiyah_entity.dart';

abstract class ImsakiyahRepository {
  Future<Result<ImsakiyahEntity>> getImsakiyahSchedule({
    required String province,
    required String city,
  });
}
