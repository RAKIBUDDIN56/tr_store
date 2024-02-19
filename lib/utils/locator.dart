import 'package:get_it/get_it.dart';
import 'package:tr_store/data/db_helper.dart';

final locator = GetIt.I;
void setupLocator() {
  locator.registerLazySingleton<DBHelper>(() => DBHelper());
}
