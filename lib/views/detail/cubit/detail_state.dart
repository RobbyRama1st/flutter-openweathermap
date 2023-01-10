part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitialState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailDisposeLoadingState extends DetailState {}

class DetailLoadSevenDaysFailedState extends DetailState {
  
  @override
  List<Object> get props => [];
}

class DetailLoadSevenDaysSuccessState extends DetailState {
  final ListWeather value;

  const DetailLoadSevenDaysSuccessState({required this.value});

  @override
  List<Object> get props => [value];
}

