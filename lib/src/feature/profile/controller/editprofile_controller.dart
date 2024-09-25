import 'dart:io';

import 'package:api_integration/src/feature/file/controller/file_controller.dart';
import 'package:api_integration/src/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileController =
    StateNotifierProvider<EditPorofileController, EditProfileState>((ref) {
  final controller = ref.watch(profielControllerProvider);
  return EditPorofileController(controller: controller, ref: ref);
});

class EditPorofileController extends StateNotifier<EditProfileState> {
  final ProfileController _controller;
  final Ref _ref;
  EditPorofileController({
    required ProfileController controller,
    required Ref ref,
  })  : _controller = controller,
        _ref = ref,
        super(EditProfileState());

  void updateState({
    String? name,
    String? phone,
    String? email,
    String? image,
    String? avatar,
    DateTime? dob,
    String? gender,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      phone: phone ?? state.phone,
      email: email ?? state.email,
      dob: dob ?? state.dob,
      gender: gender ?? state.gender,
    );
  }

  void save({required BuildContext context}) async {
    if (state.loading) {
      return;
    }
    state = state.copyWith(loading: true);
    // run code to save request.
    await _controller.updateUser(state: state, context: context);
    state = state.copyWith(loading: false);
  }

  void selectFile(String s) async {
    final file = await _ref.read(fileControllerProvider).selectFile();
    state = state.copyWith(image: file);
  }
}

class EditProfileState {
  final String name;
  final String phone;
  final String email;
  final String avatar;
  final bool loading;
  final File? image;
  final DateTime? dob;
  final String gender;

  EditProfileState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.avatar = '',
    this.loading = false,
    this.image,
    this.dob,
    this.gender = '',
  });

  EditProfileState copyWith({
    String? name,
    String? phone,
    String? email,
    String? avatar,
    bool? loading,
    File? image,
    DateTime? dob,
    String? gender,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      loading: loading ?? this.loading,
      image: image ?? this.image,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
    );
  }
}
