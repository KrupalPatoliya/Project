import 'package:equatable/equatable.dart';
import 'package:training_app/models/userdata.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final List<UserData> dataList;
  const ApiLoaded(this.dataList);
}

class ApiError extends ApiState {
  final String? message;

  const ApiError(this.message);
}
