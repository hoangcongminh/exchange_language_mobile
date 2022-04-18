part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class OnChangeIndexEvent extends DashboardEvent {
  final int index;

  const OnChangeIndexEvent({required this.index});

  @override
  List<Object> get props => [index];
}
