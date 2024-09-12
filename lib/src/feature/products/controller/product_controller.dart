import 'dart:convert';

import 'package:api_integration/src/feature/products/repo/product_repo.dart';
import 'package:api_integration/src/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final productControllerProvider = Provider((ref) {
//   final productRepo = ref.watch(productRepoProvider);
//   return ProductController(productRepo: productRepo);
// });

// class ProductController {
//   final ProductRepo _productRepo;
//   ProductController({required ProductRepo productRepo})
//       : _productRepo = productRepo;

//   Future<List<Product>> getProducts() async {
//     final response = await _productRepo.getProducts();
//     final data = jsonDecode(response!.body);
//     List<Product> products = [];
//     final productsData = data['products'];
//     for (dynamic product in productsData) {
//       products.add(Product.fromJson(product));
//     }
//     return products;
//   }
// }

final productControllerProvider =
    StateNotifierProvider<ProductController, List<Product>>((ref) {
  final productRepo = ref.watch(productRepoProvider);
  return ProductController(productRepo: productRepo);
});

class ProductController extends StateNotifier<List<Product>> {
  final ProductRepo _productRepo;

  ProductController({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super([]);

  Future<void> getProducts() async {
    final response = await _productRepo.getProducts();
    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final productsData = data['products'] as List<dynamic>;
      List<Product> products =
          productsData.map((product) => Product.fromJson(product)).toList();
      state = products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
