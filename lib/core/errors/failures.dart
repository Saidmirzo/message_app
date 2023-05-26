import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}
class ServerFailure extends Failure{}
class ConnectionFailure extends Failure{}
class BazeFailure extends Failure{}