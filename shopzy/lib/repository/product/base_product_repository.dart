import 'package:shopzy/models/models.dart';

abstract class BaseProductRepository{
  Stream<List<Product>> getAllProducts();
}

