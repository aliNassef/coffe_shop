import '../helpers/cache_helper.dart';
import '../helpers/fireauth_helper.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import '../../features/delevery/data/repo/delievery_repo.dart';
import '../../features/delevery/data/repo/delievery_repo_impl.dart';
import '../../features/delevery/presentation/controller/cubit/delivery_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentation/controller/bloc/coffe_search_bloc.dart';
import '../../features/home/presentation/controller/coffe_cubit/coffe_cubit.dart';
import '../../features/home/presentation/controller/get_user_location_cubit/get_user_location_cubit.dart';
import '../../features/order/data/repo/order_repo.dart';
import '../../features/order/data/repo/order_repo_impl.dart';
import '../../features/order/presentation/controller/bloc/get_order_position_bloc.dart';
import '../../features/order/presentation/controller/order_cubit/order_cubit.dart';
import '../controller/user_cubit/user_cubit.dart';
import '../controller/internet_connection_cubit/internet_connection_cubit.dart';
import '../helpers/firestore_helper.dart';
import '../helpers/location_helper.dart';
import '../repo/user_repo.dart';
import '../repo/user_repo_impl.dart';

final injector = GetIt.instance;

void setupServiceLocator() async {
  _setupExternal();
  _setupUserFeature();
  _setupHomeFeature();
  _setupOrderFeature();
  _setupDeleveryFeature();
  _setupAuthFeature();
}

void _setupAuthFeature() {
  injector.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(firebaseAuth: injector<FireauthHelper>()),
  );
  injector.registerFactory(() => AuthCubit(injector<AuthRepo>()));
}

void _setupDeleveryFeature() {
  injector.registerLazySingleton<DelieveryRepo>(
    () => DelieveryRepoImpl(
      firestoreHelper: injector<FirestoreHelper>(),
      locationHelper: injector<LocationHelper>(),
    ),
  );
  injector.registerFactory(() => DeliveryCubit(injector<DelieveryRepo>()));
}

void _setupOrderFeature() {
  injector.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(
      firestoreHelper: injector<FirestoreHelper>(),
      locationHelper: injector<LocationHelper>(),
    ),
  );
  injector.registerFactory(() => OrderCubit(injector<OrderRepo>()));
  injector.registerFactory(() => GetOrderPositionBloc(injector<OrderRepo>()));
}

void _setupUserFeature() {
  injector.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(
      locationHelper: injector<LocationHelper>(),
      fireauthHelper: injector<FireauthHelper>(),
      firestoreHelper: injector<FirestoreHelper>(),
      cacheHelper: injector<CacheHelper>(),
    ),
  );
  injector.registerLazySingleton<UserCubit>(
    () => UserCubit(injector<UserRepo>()),
  );
}

void _setupExternal() {
  injector.registerLazySingleton<FirestoreHelper>(() => FirestoreHelper());
  injector.registerLazySingleton<LocationHelper>(() => LocationHelper());
  injector.registerLazySingleton<FireauthHelper>(() => FireauthHelper());
  injector.registerLazySingleton<CacheHelper>(() => CacheHelper());
  injector.registerFactory<InternetConnectionCubit>(
    () => InternetConnectionCubit(),
  );
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
