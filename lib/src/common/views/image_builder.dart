import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageBuilder extends StatelessWidget {
  const CustomImageBuilder(
      {super.key,
      this.src,
      this.fit,
      this.width,
      this.height,
      this.file,
      this.icon});

  final String? src;
  final File? file;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (_isSvg(file!.path)) {
        return SvgPicture.file(file!,
            width: width, height: height, fit: fit ?? BoxFit.cover);
      }
      return Image.file(
        file!,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => defaultImage(),
      );
    }

    if (src != null) {
      if (_isSvg(src!)) {
        return SvgPicture.network(
          src!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        );
      }

      return Image.network(
        src!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => defaultImage(),
      );
    }

    return defaultImage();
  }

  Widget defaultImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      height: height,
      width: width,
      child: Icon(
        icon,
        color: Colors.white,
        size: 60,
      ),
    );
  }

  bool _isSvg(String imageUrl) {
    Uri uri = Uri.parse(imageUrl);
    List<String> pathSegments = uri.pathSegments;
    if (pathSegments.isEmpty) {
      // No path segments found
    }

    String lastPathSegment = pathSegments.last;
    int dotIndex = lastPathSegment.lastIndexOf('.');
    if (dotIndex != -1) {
      return lastPathSegment.substring(dotIndex + 1) == 'svg';
    }
    return false;
  }
}
