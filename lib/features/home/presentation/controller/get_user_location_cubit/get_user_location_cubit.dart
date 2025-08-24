import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_location_state.dart';

class GetUserLocationCubit extends Cubit<GetUserLocationState> {
  GetUserLocationCubit(this._homeRepo) : super(GetUserLocationInitial());
  final HomeRepo _homeRepo;

  void getUserLocation() async {
    emit(GetUserLocationLoading());
    final result = await _homeRepo.getUserLocation();
    result.fold(
      (failure) => emit(GetUserLocationFailure(errMessage: failure.errMessage)),
      (position) => emit(GetUserLocationLoaded(position: position)),
    );
  }
}
