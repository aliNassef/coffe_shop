import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/model/coffe_model.dart';
import '../controller/bloc/coffe_search_bloc.dart';
import '../controller/coffe_cubit/coffe_cubit.dart';
import '../view/coffe_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../widgets/coffe_item.dart';
import '../widgets/location_and_search_bar_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            width: context.width,
            height: context.height * .48,
            child: Stack(
              children: [
                LocationAndSearchBarWidget(),
                Positioned(
                  top: context.height * .26,
                  left: 16.w,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.light,
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1506372023823-741c83b836fe?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    height: context.height * .20,
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.red,
                          ),
                          child: Text(
                            'Special Offer',
                            style: AppStyles.regular20.copyWith(
                              color: AppColors.light,
                            ),
                          ).withAllPadding(5),
                        ),
                        Spacer(),
                        Text(
                          'Buy 1 Get 1 Free',
                          style: AppStyles.bold24.copyWith(
                            color: AppColors.light,
                            fontSize: 35.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<CoffeSearchBloc, CoffeSearchState>(
          builder: (context, searchState) {
            if (searchState is CoffeSearchLoading) {
              return SliverSkeletonizer(
                enabled: true,
                child: _buildLoadingCoffeItems(context),
              );
            }
            if (searchState is CoffeSearchError) {
              return SliverToBoxAdapter(
                child: CustomFailureWidget(
                  errMessage: searchState.errorMessage,
                ),
              );
            }
            if (searchState is CoffeSearchSuccess) {
              if (searchState.coffees.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No coffees found matching your search.'),
                    ),
                  ),
                );
              }
              return _buildCoffeeGrid(context, searchState.coffees);
            }
            return BlocBuilder<CoffeCubit, CoffeState>(
              buildWhen: (previous, current) =>
                  current is CoffeSuccess ||
                  current is CoffeLoading ||
                  current is CoffeError,
              builder: (context, coffeState) {
                if (coffeState is CoffeLoading) {
                  return SliverSkeletonizer(
                    enabled: true,
                    child: _buildLoadingCoffeItems(context),
                  );
                }
                if (coffeState is CoffeError) {
                  return SliverToBoxAdapter(
                    child: CustomFailureWidget(
                      errMessage: coffeState.errMessage,
                    ),
                  );
                }
                if (coffeState is CoffeSuccess) {
                  if (coffeState.coffees.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(child: Text('No coffees available')),
                    );
                  }
                  return _buildCoffeeGrid(context, coffeState.coffees);
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            );
          },
        ),
        SliverGap(30.h),
      ],
    );
  }

  SliverPadding _buildCoffeeGrid(
    BuildContext context,
    List<CoffeeModel> coffees,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 9 / 15,
        ),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              _goToDetails(context, coffees[index]);
            },
            child: CoffeItem(coffee: coffees[index]),
          );
        },
        itemCount: coffees.length,
      ),
    );
  }

  SliverPadding _buildLoadingCoffeItems(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 9 / 15,
        ),
        itemBuilder: (_, index) {
          return CoffeItem(
            coffee: CoffeeModel(
              numOfReviews: 0,
              coffeeId: "espresso_1",
              name: "Espresso",
              price: 30.0,
              size: "Small",
              count: 1,
              img:
                  "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
              rate: 4.8,
              desc: "Strong and rich single shot of espresso.",
              type: "Espresso",
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }

  void _goToDetails(BuildContext context, CoffeeModel coffee) {
    Navigator.pushNamed(context, CoffeDetailsView.routeName, arguments: coffee);
  }
}
