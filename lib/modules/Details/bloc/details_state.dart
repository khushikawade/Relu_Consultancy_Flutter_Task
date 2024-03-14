import 'package:equatable/equatable.dart';
import 'package:relu_consultancy_task/modules/Details/response_model/details_response.dart';

abstract class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DetailsScreenState {}

class DataLoading extends DetailsScreenState {}

class DataLoaded extends DetailsScreenState {
  final Track data;
  // print(data.length);

  const DataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataError extends DetailsScreenState {}
