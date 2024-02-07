import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.padding,
    this.borderRadius,
    this.logoWidth,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? logoWidth;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Assets.imagesLogo.image(
          fit: fit,
          width: width,
          height: height,
        ),
      );
    }
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return const Center(child: Text('Image'));
    }
    final memCacheHeight = height == null ? null : (height! * 2).toInt();
    final memCacheWidth = width == null ? null : (width! * 2).toInt();

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      child: Stack(
        children: [
          CachedNetworkImage(
            fit: fit,
            width: width,
            height: height,
            memCacheHeight: memCacheHeight,
            memCacheWidth: memCacheWidth,
            imageUrl: imageUrl!,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Assets.imagesLogo.image(
              fit: fit,
              width: width,
              height: height,
            ),
          ),
          if (logoWidth != null)
            Positioned.directional(
              bottom: 0,
              end: 0,
              textDirection: TextDirection.ltr,
              child: ClipPath(
                clipper: _CutEdgeClipper(),
                child: Container(
                  width: logoWidth,
                  height: logoWidth! * 0.7,
                  decoration:
                      const BoxDecoration(color: AppColors.darkBlueGrey),
                  child: Center(
                    child: Assets.imagesLogo.image(width: logoWidth! * 0.8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CutEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width * 0.2, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.2, 0);
    return path;
  }

  @override
  bool shouldReclip(_CutEdgeClipper oldClipper) => false;
}
