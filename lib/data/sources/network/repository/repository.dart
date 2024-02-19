import 'package:tr_store/data/models/product_model.dart';
import 'package:tr_store/utils/typedef.dart';

abstract interface class Repository {
  ResponseTypedef<Products> fetchProducts();
}
