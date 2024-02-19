import 'package:fluttertoast/fluttertoast.dart';
import 'package:tr_store/config/constansts/app_color.dart';

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: AppColors.primary,
      fontSize: 16.0);
}
