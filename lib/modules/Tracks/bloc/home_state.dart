import 'package:equatable/equatable.dart';

import '../respose_model/home_respose_model.dart';

abstract class TracksScreenState extends Equatable {
  const TracksScreenState();

  @override
  List<Object> get props => [];
}

class DataInitial extends TracksScreenState {}

class DataLoading extends TracksScreenState {}

class DataLoaded extends TracksScreenState {
  final List<TrackList> trackList;
  // print(data.length);

  const DataLoaded(this.trackList);

  @override
  List<Object> get props => [trackList];
}

class DataError extends TracksScreenState {}
