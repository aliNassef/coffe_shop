import 'package:bloc/bloc.dart';
import 'package:coffe_shop/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/repo/user_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.__userRepo) : super(UserIntial());
  final UserRepo __userRepo;
  void updateUserAddress(String address) {
    emit(UpdateUserAddressState(address: address));
  }

  void getUserAddress() async {
    emit(GetuserLocationLoadingState());
    final result = await __userRepo.getUserAddress();
    result.fold(
      (failure) => emit(
        GetuserLocationFailed(error: failure.errMessage),
      ), // Handle failure case
      (address) => emit(
        GetuserLocationLoadedState(address: address),
      ), // Emit new state with address
    );
  }

  void getUserCoardinate() async {
    emit(GetuserPositonLoadingState());
    final positionOrfailure = await __userRepo.getUserCoardinates();
    return positionOrfailure.fold((failure) {
      emit(GetuserPositonFailed(error: failure.errMessage));
    }, (position) => emit(GetuserPositonLoadedState(position: position)));
  }

  String getUserId() {
    return __userRepo.getuserId();
  }

  void getUserById(String id) async {
    emit(GetUserLoading());
    final userOrFailure = await __userRepo.getUser(id);
    userOrFailure.fold(
      (failure) => emit(GetUserFailed(error: failure.errMessage)),
      (user) => emit(GetUserLoaded(user: user)),
    );
  }
}
