import '../../core/usecase/result.dart';
import '../../core/usecase/usecase.dart';
import '../entities/imsakiyah_entity.dart';
import '../entities/location_entity.dart';
import '../repositories/imsakiyah_repository.dart';

class GetImsakiyahScheduleUsecase extends UseCase<Result, LocationEntity> {
  GetImsakiyahScheduleUsecase(this._imsakiyahRepository);

  final ImsakiyahRepository _imsakiyahRepository;

  @override
  Future<Result<ImsakiyahEntity>> call(LocationEntity params) async =>
      _imsakiyahRepository.getImsakiyahSchedule(
        city: params.city,
        province: params.province,
      );
}
