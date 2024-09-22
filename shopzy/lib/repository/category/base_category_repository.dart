import 'package:shopzy/models/models.dart';

abstract class BaseCategoryRepository{
  Stream<List<Category>> getAllCategories();
}