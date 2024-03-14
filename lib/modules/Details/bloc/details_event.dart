// data_event.dart
import 'package:equatable/equatable.dart';

abstract class DetailsScreenEvent extends Equatable {
  const DetailsScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailsScreenData extends DetailsScreenEvent {
  final String id;
  const FetchDetailsScreenData(this.id);

  @override
  List<Object> get props => [id];
}
