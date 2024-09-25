// import 'package:api_integration/src/feature/products/controller/product_controller.dart';
// import 'package:api_integration/src/res/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ProductView extends ConsumerWidget {
//   const ProductView({super.key});
//   static const routePath = '/product';

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product"),
//       ),
//       body: FutureBuilder(
//         future: ref.watch(productControllerProvider).getProducts(),
//         builder: (context, snapshot) {
//           snapshot.data;
//           if (snapshot.data == null) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final products = snapshot.data!;
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 padding: const EdgeInsets.all(8.0),
//                 margin: const EdgeInsets.all(10),
//                 color: AppColors.cardColor,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(products[index].id.toString()),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Text(products[index].title),
//                         ),
//                       ],
//                     ),
//                     Text(products[index].description),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// ###################### 2nd Method ######################
// import 'package:api_integration/src/feature/products/controller/product_controller.dart';
// import 'package:api_integration/src/res/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ProductView extends ConsumerWidget {
//   const ProductView({super.key});
//   static const routePath = '/product';

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Call the product fetching method when the widget is built
//     final productController =
//         ref.read(productControllerProvider.notifier).getProducts();

//     final products = ref.watch(productControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product"),
//       ),
//       body: products.isEmpty
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: const EdgeInsets.all(8.0),
//                   margin: const EdgeInsets.all(10),
//                   color: AppColors.cardColor,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(products[index].id.toString()),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(products[index].title),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       Text(products[index].description),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//  ###################### 3rd Method ######################
import 'package:api_integration/src/feature/products/controller/product_controller.dart';
import 'package:api_integration/src/feature/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  static const routePath = '/product';

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends ConsumerState<ProductView> {
  @override
  void initState() {
    super.initState();
    // Now you can use `ref.read` in initState
    ref.read(productControllerProvider.notifier).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push(ProfileScreen.routePath);
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].title),
                  subtitle: Text(products[index].description),
                );
              },
            ),
    );
  }
}
