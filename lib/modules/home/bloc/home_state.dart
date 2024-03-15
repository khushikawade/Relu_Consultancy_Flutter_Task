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
  final List<TrackList> trackList;
  // print(data.length);

  const DataLoaded(this.trackList);

  @override
  List<Object> get props => [trackList];
}

class DataError extends HomeScreenState {}
