import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/place.dart';
import 'package:travel_app_with_animations/theme/text_theme_x.dart';

class GradientStatusTag extends StatelessWidget {
  const GradientStatusTag({
    Key? key,
    required this.statusTag,
  }) : super(key: key);

  final StatusTag statusTag;

  @override
  Widget build(BuildContext context) {
    String text;
    List<Color> colors;
    switch (statusTag) {
      case StatusTag.popular:
        text = 'Popular places';
        colors = [Colors.amber, Colors.orange.shade600];
        break;
      case StatusTag.event:
        text = 'Event';
        colors = [Colors.cyan, Colors.blue.shade600];
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(colors: colors),
      ),
      child: Text(
        text,
        style: context.subtitle1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
