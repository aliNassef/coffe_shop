import 'dart:developer';

import '../../../../core/controller/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/helpers/order_status_enum.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../../order/data/models/order_model.dart';
import '../../data/model/deleivery_model.dart';
import '../controller/cubit/delivery_cubit.dart';

class AcceptorRejectOrderButton extends StatefulWidget {
  const AcceptorRejectOrderButton({super.key, required this.order});

  final OrderModel order;

  @override
  State<AcceptorRejectOrderButton> createState() =>
      _AcceptorRejectOrderButtonState();
}

class _AcceptorRejectOrderButtonState extends State<AcceptorRejectOrderButton> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserCoardinate();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          widget.order.status == getOrderStatusName(OrderStatus.notStartedYet),
      replacement: Container(),
      child: Row(
        spacing: 16.w,
        children: [
          Expanded(
            child: DefaultAppButton(
              text: 'Reject',
              onPressed: () {
                var deliveryModel = DeleiveryModel(
                  deliveryId: context.read<UserCubit>().getUserId(),
                  deliveryName: 'Mohammed',
                  deliveryPhone: '01128861472',
                  deliveryLat: 11,
                  deliveryLong: 11,
                  status: getOrderStatusName(OrderStatus.rejected),
                );
                context.read<DeliveryCubit>().actionOnOrder(
                  deleiveryModel: deliveryModel,
                  orderId: widget.order.orderId,
                );
              },
              backgroundColor: Colors.red,
            ),
          ),

          Expanded(
            child: BlocSelector<UserCubit, UserState, Position?>(
              selector: (state) {
                if (state is GetuserPositonLoadedState) {
                  return state.position;
                } else {
                  return null;
                }
              },
              builder: (context, state) {
                log(state.toString());
                return DefaultAppButton(
                  text: 'Accept',
                  onPressed: () {
                    (String, String) nameAndPhone = context
                        .read<UserCubit>()
                        .getuserNameAndPhone();
                    var deliveryModel = DeleiveryModel(
                      deliveryId: context.read<UserCubit>().getUserId(),
                      deliveryName: nameAndPhone.$1,
                      deliveryPhone: nameAndPhone.$2,
                      deliveryLat: state!.latitude,
                      deliveryLong: state.longitude,
                      status: getOrderStatusName(OrderStatus.onTheWay),
                    );
                    context.read<DeliveryCubit>().actionOnOrder(
                      deleiveryModel: deliveryModel,
                      orderId: widget.order.orderId,
                    );
                  },
                  backgroundColor: Colors.green,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
