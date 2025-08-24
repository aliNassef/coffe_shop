import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/model/coffe_model.dart';
import '../../../data/repo/home_repo.dart';

part 'coffe_search_event.dart';
part 'coffe_search_state.dart';

class CoffeSearchBloc extends Bloc<CoffeSearchEvent, CoffeSearchState> {
  final HomeRepo _homeRepo;
  CoffeSearchBloc(this._homeRepo) : super(CoffeSearchInitial()) {
    on<CoffeSearchEvent>(
      (event, emit) async {
        if (event is CoffeSearchQueryChanged) {
          emit(CoffeSearchLoading());
          final coffeesOrFailure = await _homeRepo.searchOnCoffees(event.query);
          coffeesOrFailure.fold(
            (failure) {
              emit(CoffeSearchError(failure.errMessage));
            },
            (coffees) {
              emit(CoffeSearchSuccess(coffees));
            },
          );
        }
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .switchMap(mapper);
      },
    );
  }
}
