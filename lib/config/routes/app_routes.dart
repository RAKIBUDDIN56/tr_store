import 'package:go_router/go_router.dart';
import 'package:tr_store/config/config.dart';
import 'package:tr_store/screens/cart_screen.dart';
import 'package:tr_store/screens/home_screen.dart';
import 'package:tr_store/screens/product_details_screen.dart';
import 'package:tr_store/screens/splash_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: RouteLocation.splash,
    builder: SplashScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.cart,
    builder: CartScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.home,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: "${RouteLocation.detail}/:index",
   
    builder: (context, state) {
      final id = state.pathParameters["index"];
      return ProductDetailsScrren(index: int.parse(id!));
    },
  ),
]);
