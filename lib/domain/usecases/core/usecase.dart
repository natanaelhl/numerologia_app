import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';

abstract class Usecase<R, P> {
  Future<Either<Failure, R>> call (P parameter);
}

class NoParameter {}