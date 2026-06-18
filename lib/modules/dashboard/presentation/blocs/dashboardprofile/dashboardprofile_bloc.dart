import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/component/image_picker/image_picker.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardprofile_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardprofile_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardprofile_view_initial_params.dart';

part 'dashboardprofile_event.dart';
part 'dashboardprofile_state.dart';

class DashboardprofileBloc
    extends Bloc<DashboardprofileEvent, DashboardprofileState> {
  // final ImagePicker _picker = ImagePicker();
  final DashboardprofileViewInitialParams initialParams;
  final DashboardprofileUseCase _useCase;

  DashboardprofileBloc(this.initialParams, this._useCase)
    : super(DashboardprofileState(initialParams: initialParams)) {
    on<LoadDashboardprofileEvent>(_loadDashboardprofileAction);
    on<PickImageFromGallery>(_onPickImage);
  }

  Future<void> _loadDashboardprofileAction(
    LoadDashboardprofileEvent event,
    Emitter<DashboardprofileState> emit,
  ) async {
    emit(state.copyWith(dashboardprofileResponse: ApiResponse.loading()));

    await _useCase
        .execute(event.param)
        .then(
          (value) => value.fold(
            (l) {
              emit(
                state.copyWith(
                  dashboardprofileResponse: ApiResponse.error(l.error),
                ),
              );
            },
            (r) {
              emit(
                state.copyWith(
                  dashboardprofileResponse: ApiResponse.completed(r),
                ),
              );
            },
          ),
        );
  }

  Future<void> _onPickImage(
    PickImageFromGallery event,
    Emitter<DashboardprofileState> emit,
  ) async {
    try {
      File? pickedFile = await AppImagePicker.pickFromGallery();

      if (pickedFile != null) {
        emit(state.copyWith(image: pickedFile));
      }
      // If user cancels → do nothing OR keep old state
    } catch (e) {
      // Optional: log error
      Utils.logError(e.toString());
    }
  }
}
