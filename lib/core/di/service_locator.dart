import '../helpers/firestore_helper.dart';
import '../helpers/location_helper.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentation/controller/coffe_cubit/coffe_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/controller/bloc/coffe_search_bloc.dart';
import '../../features/home/presentation/controller/get_user_location_cubit/get_user_location_cubit.dart';
import '../../features/order/data/repo/order_repo.dart';
import '../../features/order/data/repo/order_repo_impl.dart';
import '../../features/order/presentation/controller/cubit/order_cubit.dart';

final injector = GetIt.instance;

void setupServiceLocator() async {
  _setupExternal();
  _setupHomeFeature();
  _setupOrderFeature();
}

void _setupOrderFeature() {
  injector.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(locationHelper: injector<LocationHelper>()),
  );
  injector.registerLazySingleton<OrderCubit>(
    () => OrderCubit(injector<OrderRepo>()),
  );
}

void _setupExternal() {
  injector.registerLazySingleton<FirestoreHelper>(() => FirestoreHelper());
  injector.registerLazySingleton<LocationHelper>(() => LocationHelper());
}

void _setupHomeFeature() {
  injector.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      firestoreHelper: injector<FirestoreHelper>(),
      locationHelper: injector<LocationHelper>(),
    ),
  );
  injector.registerFactory(() => CoffeCubit(injector<HomeRepo>()));
  injector.registerFactory(() => CoffeSearchBloc(injector<HomeRepo>()));
  injector.registerFactory(() => GetUserLocationCubit(injector<HomeRepo>()));
}
