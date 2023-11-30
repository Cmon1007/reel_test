import 'package:flutter/material.dart';

class LikeActionWidget extends StatelessWidget {
  const LikeActionWidget({
    Key? key,
    required this.backgroundColor,
    required this.iconUrl,
    this.iconColor,
    this.fontWeight,
  }) : super(key: key);
  final Color backgroundColor;
  final IconData iconUrl;
  final Color? iconColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconUrl,
            color: iconColor,
            size: 30,
          )
        ],
      ),
    );
  }
}
