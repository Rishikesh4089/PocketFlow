import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/category_repository.dart';
import '../../models/category.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;

  CategoryBloc(this._repository) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        _repository.getCategories().listen((categories) {
          emit(CategoryLoaded(categories));
        });
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      try {
        await _repository.addCategory(event.category);
        add(LoadCategories()); // Refresh after adding
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
