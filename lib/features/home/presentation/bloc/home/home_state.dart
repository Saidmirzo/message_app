part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState({required this.message});
}
