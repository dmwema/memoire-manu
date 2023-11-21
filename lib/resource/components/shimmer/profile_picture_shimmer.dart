import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePictureShimmer extends StatelessWidget {
  final bool rounded;

  const ProfilePictureShimmer({super.key, this.rounded = false});

  @override
  Widget build(BuildContext context) {
    //return Text("loading");
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[350]!,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
            borderRadius: BorderRadius.circular(rounded ? 100 : 5)
        ),
      ),
    );
  }
}