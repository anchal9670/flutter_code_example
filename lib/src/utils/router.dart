import 'package:api_integration/src/common/views/splash.dart';
import 'package:api_integration/src/feature/products/views/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: ProductView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const ProductView();
      },
    ),
  ],
);
