import 'package:equatable/equatable.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/response_model/details_response.dart';

abstract class TrackDetailsScreenState extends Equatable {
  const TrackDetailsScreenState();

  @override
  List<Object> get props => [];
}

class DataInitial extends TrackDetailsScreenState {}

class DataLoading extends TrackDetailsScreenState {}

class DataLoaded extends TrackDetailsScreenState {
  final Track data;
  // print(data.length);

  const DataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataError extends TrackDetailsScreenState {}
