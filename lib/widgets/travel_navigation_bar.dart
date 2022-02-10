import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/travel_navigation_bar_item.dart';

class TravelNavigationBar extends StatelessWidget {
  final List<TravelNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  const TravelNavigationBar({
    Key? key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
  })  : assert(items.length == 2, ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NavPainter(),
      child: SizedBox(
        height: kToolbarHeight + 20,
        child: Row(
          children: List.generate(
            items.length,
            (index) => Expanded(
              child: Icon(
                currentIndex == index
                    ? items[index].selectedIcon
                    : items[index].icon,
                color: currentIndex == index
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
          )..insert(1, const Spacer()),
        ),
      ),
    );
  }
}

class _NavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final h5 = h * .5;
    final w5 = w * .5;
    final h6 = w * .6;

    final path = Path()
      ..lineTo(w5 - 80, 0)
      ..cubicTo((w5 - 40), 0, (w5 - 40), h5, w5, h5 - 3)
      ..lineTo(w5, h)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..lineTo(w5 + 80, 0)
      ..cubicTo((w5 + 40), 0, (w5 + 40), h5, w5, h5 - 3)
      ..lineTo(w5, h6)
      ..lineTo(w5, h)
      ..lineTo(0, h);

    canvas.drawShadow(path, Colors.black26, 10, false);
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
