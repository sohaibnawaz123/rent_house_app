import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';

class AvaterWidget extends StatelessWidget {
  final String? imageUrl; // network
  final File? fileImage; // local file
  final void Function()? onTap;

  const AvaterWidget({super.key, this.imageUrl, this.fileImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColor.highlight,
            backgroundImage: fileImage != null
                ? FileImage(fileImage!) // ✅ LOCAL IMAGE
                : (imageUrl != null && imageUrl!.isNotEmpty
                      ? NetworkImage(imageUrl!) // ✅ NETWORK IMAGE
                      : null),
            child: fileImage == null && (imageUrl == null || imageUrl!.isEmpty)
                ? Icon(Icons.person, color: AppColor.white, size: 48)
                : null,
          ),
      
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColor.btnBg,
                child: AppImage.svg(svgPath: AppAsset.camera, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
