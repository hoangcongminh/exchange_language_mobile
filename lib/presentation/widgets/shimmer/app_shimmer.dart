import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatefulWidget {
  final Color? highlightColor;
  final Color? baseColor;
  final double radius;
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const AppShimmer(
      {Key? key,
      this.highlightColor,
      this.baseColor,
      this.radius = 0,
      required this.width,
      required this.height,
      this.borderRadius})
      : super(key: key);

  factory AppShimmer.round({
    required double size,
    Color? highlightColor,
    Color? baseColor,
  }) =>
      AppShimmer(
          width: size,
          height: size,
          radius: size / 2,
          highlightColor: highlightColor,
          baseColor: baseColor);

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer> {
  Color get highlightColor => const Color(0xffF9F9FB);

  Color get baseColor => const Color(0xffE6E8EB);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      baseColor: widget.baseColor ?? baseColor,
      highlightColor: widget.highlightColor ?? highlightColor,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: widget.radius == 0
              ? widget.borderRadius
              : BorderRadius.circular(widget.radius),
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
