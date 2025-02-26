import '../../models/category.dart';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final Category category;
  AddCategory(this.category);
}
