import 'package:equatable/equatable.dart';

import '../respose_model/home_respose_model.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class DataInitial extends HomeScreenState {}

class DataLoading extends HomeScreenState {}

class DataLoaded extends HomeScreenState {
  final List<TrackList> data;
  // print(data.length);

  const DataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataError extends HomeScreenState {}
