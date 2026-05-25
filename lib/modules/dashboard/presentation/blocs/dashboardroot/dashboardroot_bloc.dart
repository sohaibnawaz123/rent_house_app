import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';

part 'dashboardroot_event.dart';
part 'dashboardroot_state.dart';

class DashboardrootBloc extends Bloc<DashboardrootEvent, DashboardrootState> {
  final DashboardrootViewInitialParams initialParams;

  DashboardrootBloc(this.initialParams)
    : super(DashboardrootState.initail(initialParams)) {
    on<ChangeNavigationEvent>(_onChange);
    on<InitializeNavigationEvent>(_onInitialize);
  }

  void _onChange(
    ChangeNavigationEvent event,
    Emitter<DashboardrootState> emit,
  ) {
    emit(
      state.copyWith(
        currentItems: event.item,
        currentTitle: event.title ?? event.item.lable,
      ),
    );
  }

  void _onInitialize(
    InitializeNavigationEvent event,
    Emitter<DashboardrootState> emit,
  ) {
    emit(state.copyWith(navItems: NavItemEntity.allItems));
  }
}
