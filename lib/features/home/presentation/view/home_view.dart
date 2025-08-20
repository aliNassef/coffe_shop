import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../controller/bloc/coffe_search_bloc.dart';
import '../controller/coffe_cubit/coffe_cubit.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => injector<CoffeCubit>()..getCoffees(),
          ),
          BlocProvider(create: (context) => injector<CoffeSearchBloc>()),
        ],
        child: HomeViewBody(),
      ),
    );
  }
}
