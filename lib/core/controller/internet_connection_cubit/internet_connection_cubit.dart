import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());
  StreamSubscription? _internetConnectionSubscription;

  void monitorInternetConnection() {
    _internetConnectionSubscription = InternetConnection().onStatusChange
        .listen((InternetStatus status) {
          switch (status) {
            case InternetStatus.connected:
              emit(InternetConnectionConnected());
              break;
            case InternetStatus.disconnected:
              emit(InternetConnectionDisConnected());
              break;
          }
        });
  }

  @override
  Future<void> close() {
    _internetConnectionSubscription?.cancel();
    return super.close();
  }
}
