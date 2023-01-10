part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashDisposeLoading extends SplashState {}

class SplashLoadSuccess extends SplashState {
  final CurrentWeather value;

  const SplashLoadSuccess({required this.value});

  @override
  List<Object> get props => [value];
}

class SplashLoadFailed extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashGoHome extends SplashState {}