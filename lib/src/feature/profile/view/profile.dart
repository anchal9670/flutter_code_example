import 'dart:ui';

import 'package:api_integration/src/common/views/image_builder.dart';
import 'package:api_integration/src/feature/profile/controller/editprofile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const routePath = '/profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedImageFile =
        ref.watch(editProfileController.select((value) => value.image));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Stack(
              children: [
                ClipOval(
                  child: CustomImageBuilder(
                    src:
                        "https://i.postimg.cc/vTyJJJN0/Screenshot-2024-08-24-200220.png",
                    file: selectedImageFile,
                    height: 110,
                    width: 110,
                    icon: Icons.person,
                  ),
                ),
                Positioned.fill(
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(editProfileController.notifier)
                                  .selectFile('avatar');
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
