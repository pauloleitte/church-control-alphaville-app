import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';

import '../models/visitor_model.dart';
import '../repositories/visitor_repository.dart';
import '../view-model/visitor_view_model.dart';
import 'interfaces/visitor_service_interfaces.dart';

class VisitorService implements IVisitorService {
  final VisitorRepository _repository;

  VisitorService(this._repository);

  @override
  Future<Either<Failure, VisitorModel>> createVisitor(VisitorViewModel model) {
    return _repository.createVisitor(VisitorModel(
        church: model.church,
        name: model.name,
        email: model.email,
        telephone: model.telephone,
        isChurchgoer: model.isChurchgoer,
        observations: model.observations));
  }

  @override
  Future<Either<Failure, bool>> deleteVisitor(VisitorViewModel model) {
    return _repository.deleteVisitor(model.id.toString());
  }

  @override
  Future<Either<Failure, VisitorModel>> getVisitor(VisitorViewModel model) {
    return _repository.getVisitor(model.id.toString());
  }

  @override
  Future<Either<Failure, ResponseVisitors>> getVisitors(FilterOptions options) {
    return _repository.getVisitors(options);
  }

  @override
  Future<Either<Failure, ResponseFindAllVisitors>> findAll() {
    return _repository.findAll();
  }

  @override
  Future<Either<Failure, ResponseFindCreatedAtToday>> findCreatedAtToday() {
    return _repository.findCreatedAtToday();
  }

  @override
  Future<Either<Failure, List<VisitorModel>>> getVisitorsByName(String filter) {
    return _repository.getVisitorsByName(filter);
  }

  @override
  Future<Either<Failure, VisitorModel>> updateVisitor(VisitorViewModel model) {
    return _repository.updateVisitor(VisitorModel(
        sId: model.id,
        church: model.church,
        name: model.name,
        email: model.email,
        telephone: model.telephone,
        isChurchgoer: model.isChurchgoer,
        observations: model.observations));
  }

  @override
  void dispose() {}
}
