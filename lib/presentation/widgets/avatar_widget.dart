import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange_language_mobile/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final BoxShape shape;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;

  const AvatarWidget({
    Key? key,
    this.imageUrl,
    required this.height,
    required this.width,
    this.shape = BoxShape.circle,
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
            placeholder: (context, url) => PlaceHolderAvatar(
              height: height,
              width: width,
              shape: shape,
            ),
            errorWidget: (context, url, error) => DefaultAvatar(
              height: height,
              width: width,
              shape: shape,
              margin: margin,
            ),
          )
        : DefaultAvatar(
            height: height,
            width: width,
            shape: shape,
          );
  }
}

class PlaceHolderAvatar extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;

  const PlaceHolderAvatar({
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

class DefaultAvatar extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const DefaultAvatar({
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
          image: AssetImage('assets/images/no_data.jpg'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
