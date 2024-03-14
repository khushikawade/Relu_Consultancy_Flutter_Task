// data_event.dart
import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeScreenData extends HomeScreenEvent {}
