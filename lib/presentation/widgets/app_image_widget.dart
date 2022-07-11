import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange_language_mobile/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class AppImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? assetsImageUrl;
  final double height;
  final double width;
  final BoxShape shape;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;

  const AppImageWidget({
    Key? key,
    this.imageUrl,
    this.assetsImageUrl,
    required this.height,
    required this.width,
    this.shape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              margin: margin,
              decoration: BoxDecoration(
                shape: shape,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => PlaceHolderImage(
              height: height,
              width: width,
              shape: shape,
            ),
            errorWidget: (context, url, error) => DefaultImage(
              height: height,
              width: width,
              shape: shape,
              margin: margin,
            ),
          )
        : assetsImageUrl != null
            ? Container(
                height: height,
                width: width,
                margin: margin,
                decoration: BoxDecoration(
                  shape: shape,
                  image: DecorationImage(
                    image: AssetImage(assetsImageUrl!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            : DefaultImage(
                height: height,
                width: width,
                shape: shape,
              );
  }
}

class PlaceHolderImage extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;

  const PlaceHolderImage({
    Key? key,
    required this.height,
    required this.width,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shape == BoxShape.circle
        ? AppShimmer.round(size: height)
        : AppShimmer(width: width, height: height);
  }
}

class DefaultImage extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const DefaultImage({
    Key? key,
    required this.height,
    required this.width,
    required this.shape,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        image: const DecorationImage(
          image: AssetImage('assets/images/image_placeholder.jpg'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
