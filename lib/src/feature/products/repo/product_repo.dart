import 'dart:developer';

import 'package:api_integration/src/core/core.dart';
import 'package:api_integration/src/res/endpoints.dart';
import 'package:api_integration/src/res/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return ProductRepo(api: api);
});

class ProductRepo {
  final API _api;
  ProductRepo({required API api}) : _api = api;
  Future<Response?> getProducts() async {
    final result =
        await _api.getRequest(url: Endpoints.getProducts, requireAuth: false);
    return result.fold((Failure failure) {
      log(FailureMessage.getRequestMessage);
      return null;
    }, (Response response) {
      return response;
    });
  }
}
