import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../../shared/errors/errors.dart';
import '../../models/visitor_model.dart';

abstract class IVisitorRepository implements Disposable {
  Future<Either<Failure, ResponseVisitors>> getVisitors(FilterOptions options);
  Future<Either<Failure, ResponseFindAllVisitors>> findAll();
  Future<Either<Failure, ResponseFindCreatedAtToday>> findCreatedAtToday();
  Future<Either<Failure, List<VisitorModel>>> getVisitorsByName(String filter);
  Future<Either<Failure, VisitorModel>> getVisitor(String id);
  Future<Either<Failure, VisitorModel>> createVisitor(VisitorModel model);
  Future<Either<Failure, VisitorModel>> updateVisitor(VisitorModel model);
  Future<Either<Failure, bool>> deleteVisitor(String id);
}
