import 'package:api_integration/src/core/core.dart';
import 'package:api_integration/src/feature/file/repository/file_repo.dart';
import 'package:api_integration/src/feature/profile/controller/editprofile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final profileRepoProvider = Provider((ref) {
  final network = ref.watch(apiProvider);
  return ProfileRepo(api: network, ref: ref);
});

class ProfileRepo {
  final API _api;
  final Ref _ref;
  ProfileRepo({
    required API api,
    required Ref ref,
  })  : _api = api,
        _ref = ref;

  Future<Map<String, dynamic>> update({required EditProfileState state}) async {
    final body = <String, dynamic>{};
    final info = await _ref
        .read(fileRepoProvider)
        .uploadFile(file: state.image!, type: UploadFileType.AVATAR);
    if (info != null) {
      body['avatar'] = info.fileName;
    }
    return body;
  }
}
