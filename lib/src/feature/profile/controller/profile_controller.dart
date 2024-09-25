import 'dart:convert';
import 'dart:developer';
import 'package:api_integration/src/common/views/splash.dart';
import 'package:api_integration/src/feature/products/views/product.dart';
import 'package:api_integration/src/feature/profile/controller/editprofile_controller.dart';
import 'package:api_integration/src/feature/profile/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final profielControllerProvider = Provider((ref) {
  final repo = ref.watch(profileRepoProvider);
  return ProfileController(repo: repo, ref: ref);
});

class ProfileController {
  final ProfileRepo _repo;
  final Ref _ref;
  ProfileController({
    required ProfileRepo repo,
    required Ref ref,
  })  : _repo = repo,
        _ref = ref;

  Future<void> updateUser(
      {required EditProfileState state, required BuildContext context}) async {
    final result = await _repo.update(state: state);
    context.push(ProductView.routePath);
  }
}
