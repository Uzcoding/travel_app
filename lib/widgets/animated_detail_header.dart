import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/place.dart';
import 'package:travel_app_with_animations/theme/text_theme_x.dart';
import 'package:travel_app_with_animations/widgets/translate_animation.dart';

import 'gradient_status_tag.dart';
import 'places_images_page_view.dart';

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader({
    Key? key,
    required this.place,
    required this.topPercent,
    required this.bottomPercent,
  }) : super(key: key);

  final TravelPlace place;
  final double topPercent;
  final double bottomPercent;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final imageUrl = place.imagesUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: place.id,
          child: Material(
            child: ClipRect(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: (20 + topPadding) * (1 - bottomPercent),
                      bottom: 160 * (1 - bottomPercent),
                    ),
                    child: Transform.scale(
                      scale: lerpDouble(1, 1.3, bottomPercent)!,
                      child: PlaceImagesPageView(
                        place: place,
                        imageUrl: imageUrl,
                      ),
                    ),
                  ),
                  Positioned(
                    top: topPadding,
                    left: -60 * (1 - bottomPercent),
                    child: const BackButton(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: topPadding,
                    right: -60 * (1 - bottomPercent),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: lerpDouble(20, 140, topPercent)!
                        .clamp(topPadding + 10, 140),
                    left: lerpDouble(60, 20, topPercent)!.clamp(20.0, 50.0),
                    right: 20,
                    child: AnimatedOpacity(
                      opacity: bottomPercent < 1 ? 0 : 1,
                      duration: kThemeAnimationDuration,
                      child: Opacity(
                        opacity: topPercent,
                        child: Text(
                          place.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: lerpDouble(20, 40, topPercent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 200,
                    child: AnimatedOpacity(
                      opacity: bottomPercent < 1 ? 0 : 1,
                      duration: kThemeAnimationDuration,
                      child: Opacity(
                        opacity: topPercent,
                        child: GradientStatusTag(
                          statusTag: place.statusTag,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: null,
          bottom: -140 * (1 - topPercent),
          child: TranslateAnimation(
            child: _LikesAndSharesContainer(place: place),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 10.0,
          ),
        ),
        Positioned.fill(
          top: null,
          child: TranslateAnimation(
            child: _UserInfoContainer(place: place),
          ),
        ),
      ],
    );
  }
}

class _UserInfoContainer extends StatelessWidget {
  const _UserInfoContainer({
    Key? key,
    required this.place,
  }) : super(key: key);

  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(place.user.urlPhoto),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.user.name,
                style: context.bodyText1,
              ),
              Text(
                'yesterday at 9:10 p.m',
                style: context.bodyText2.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.blue.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: const Text('+Follow'),
          ),
        ],
      ),
    );
  }
}

class _LikesAndSharesContainer extends StatelessWidget {
  const _LikesAndSharesContainer({
    Key? key,
    required this.place,
  }) : super(key: key);

  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.blue.shade50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.black,
              textStyle: context.subtitle1,
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart,
              size: 26.0,
            ),
            label: Text(
              place.likes.toString(),
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.black,
              textStyle: context.subtitle1,
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.reply,
              size: 26.0,
            ),
            label: Text(
              place.shared.toString(),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              primary: Colors.blue.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outlined,
              size: 26.0,
            ),
            label: const Text('Checkin'),
          ),
        ],
      ),
    );
  }
}
