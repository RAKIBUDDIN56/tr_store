import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/config/config.dart';
import 'package:tr_store/provider/cart_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: Builder(builder: (context) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) => MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.getAppTheme(context, false),
                    routerConfig: router,
                  ));
        }));
  }
}
