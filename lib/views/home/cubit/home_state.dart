part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeDisposeLoadingState extends HomeState {}

class HomeLoadCurrentSuccessState extends HomeState {
  final CurrentWeather value;

  const HomeLoadCurrentSuccessState({required this.value});

  @override
  List<Object> get props => [value];
}

class HomeLoadCurrentFailedState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadHourlySuccessState extends HomeState {
  final ListWeather value;

  const HomeLoadHourlySuccessState({required this.value});

  @override
  List<Object> get props => [value];
}

class HomeLoadHourlyFailedState extends HomeState {
  @override
  List<Object> get props => [];
}
