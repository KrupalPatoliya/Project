import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetApiList extends ApiEvent {}
