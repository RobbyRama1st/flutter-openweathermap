part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomeState {}

class HomePageLoading extends HomeState {}

class HomePageDisposeLoading extends HomeState {}

class HomePageLoadSuccess extends HomeState {
  final WeatherForecast value;

  const HomePageLoadSuccess({required this.value});

  @override
  List<Object> get props => [value];
}

class HomePageLoadFailed extends HomeState {
  @override
  List<Object> get props => [];
}


class HomePageLoadError extends HomeState {}
