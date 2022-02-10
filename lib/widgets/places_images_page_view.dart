import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/place.dart';

class PlaceImagesPageView extends StatefulWidget {
  const PlaceImagesPageView({
    Key? key,
    required this.place,
    required this.imageUrl,
  }) : super(key: key);

  final TravelPlace place;
  final List<String> imageUrl;

  @override
  State<PlaceImagesPageView> createState() => _PlaceImagesPageViewState();
}

class _PlaceImagesPageViewState extends State<PlaceImagesPageView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) => setState(() => currentIndex = value),
            controller: PageController(viewportFraction: .9),
            itemCount: widget.place.imagesUrl.length,
            itemBuilder: (context, index) {
              final imageUrl = widget.place.imagesUrl[index];
              final isSelected = currentIndex == index;
              return AnimatedContainer(
                duration: kThemeAnimationDuration,
                margin: EdgeInsets.only(
                  right: 10.0,
                  top: isSelected ? 5.0 : 20.0,
                  bottom: isSelected ? 5.0 : 20.0,
                ),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageUrl.length,
            (index) {
              final isSelected = currentIndex == index;
              return AnimatedContainer(
                duration: kThemeAnimationDuration,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                color: isSelected ? Colors.black38 : Colors.black12,
                height: 3.0,
                width: isSelected ? 20.0 : 10.0,
              );
            },
          ),
        ),
        const SizedBox(height: kToolbarHeight - 30),
      ],
    );
  }
}
