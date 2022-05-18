import 'package:flutter/material.dart';
import 'package:hm_service/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final ValueChanged<int>? onRatingChanged;
  final Color color;
  final bool allowStar;
  final double iconSize;

  const StarRating({Key? key, this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color = kStar, this.iconSize=20,this.allowStar = false}) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
       allowStar?Icons.star: Icons.star_border,
        color: kGreyMedium,
        size: iconSize,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: iconSize,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: iconSize,

      );
    }
    return InkResponse(
      splashColor: Colors.transparent,
      onTap: onRatingChanged == null ? null : () => onRatingChanged!.call(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}