import 'package:bloc/bloc.dart';
import '../../../data/repo/order_repo.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._orderRepo) : super(OrderInitial());
  final OrderRepo _orderRepo;
  void updateUserAddress(String address) {
    emit(UpdateUserAddressState(address: address));
  }

  void getUserAddress() async {
    emit(GetuserLocationLoading());
    final result = await _orderRepo.getUserAddress();
    result.fold(
      (failure) => emit(
        GetuserLocationFailed(error: failure.errMessage),
      ), // Handle failure case
      (address) => emit(
        GetuserLocationLoaded(address: address),
      ), // Emit new state with address
    );
  }
}
