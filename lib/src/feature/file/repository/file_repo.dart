import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:api_integration/src/core/api.dart';
import 'package:api_integration/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

final fileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return FileRepo(api: api);
});

class FileRepo {
  final API _api;
  FileRepo({required API api}) : _api = api;

  Future<UplaodInfo?> _getUploadUrl({
    required String extension,
    required UploadFileType type,
  }) async {
    final body = {"extension": extension, "type": type.text};

    final result = await _api.postRequest(
        url: Endpoints.getUploadUrl, body: body, requireAuth: false);
    return result.fold((l) {
      log('Failed to get downloadUrl');
      return null;
    }, (r) {
      final data = jsonDecode(r.body);
      final info = UplaodInfo.fromMap(data);
      return info;
    });
  }

  Future<UplaodInfo?> uploadFile(
      {required File file, required UploadFileType type}) async {
    final extension = _getFileExstension(file);
    final info = await _getUploadUrl(extension: extension, type: type);
    if (info != null) {
      final fileUploadSuccess =
          await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File Uploaded succfully');
        return info;
      }
    }
    return null;
  }

  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response =
        await http.put(Uri.parse(uploadUrl), body: file.readAsBytesSync());
    return (response.statusCode == 200);
  }

  String _getFileExstension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  AVATAR('AVATAR');

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text) {
      case "avatar":
        return UploadFileType.AVATAR;
    }
    return UploadFileType.AVATAR;
  }
}

class UplaodInfo {
  final String downloadUrl;
  final String fileName;
  final String uploadUrl;
  UplaodInfo({
    required this.downloadUrl,
    required this.fileName,
    required this.uploadUrl,
  });

  UplaodInfo copyWith({
    String? downloadUrl,
    String? fileName,
    String? uploadUrl,
  }) {
    return UplaodInfo(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      fileName: fileName ?? this.fileName,
      uploadUrl: uploadUrl ?? this.uploadUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'downloadUrl': downloadUrl,
      'fileName': fileName,
      'uploadUrl': uploadUrl,
    };
  }

  factory UplaodInfo.fromMap(Map<String, dynamic> map) {
    return UplaodInfo(
      downloadUrl: map['downloadUrl'] as String,
      fileName: map['fileName'] as String,
      uploadUrl: map['uploadUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UplaodInfo.fromJson(String source) =>
      UplaodInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UplaodInfo(downloadUrl: $downloadUrl, fileName: $fileName, uploadUrl: $uploadUrl)';

  @override
  bool operator ==(covariant UplaodInfo other) {
    if (identical(this, other)) return true;

    return other.downloadUrl == downloadUrl &&
        other.fileName == fileName &&
        other.uploadUrl == uploadUrl;
  }

  @override
  int get hashCode =>
      downloadUrl.hashCode ^ fileName.hashCode ^ uploadUrl.hashCode;
}
