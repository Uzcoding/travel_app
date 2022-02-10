import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/place.dart';
import 'package:travel_app_with_animations/theme/text_theme_x.dart';

import 'gradient_status_tag.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.place,
    required this.onTapped,
  }) : super(key: key);

  final TravelPlace place;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final statusTag = place.statusTag;
    return InkWell(
      onTap: onTapped,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(place.imagesUrl.first),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black26,
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(place.user.urlPhoto),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.user.name,
                      style: context.bodyText1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'yesterday at 9:10 p.m',
                      style: context.bodyText1.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              place.name,
              style: context.headline2,
            ),
            const SizedBox(height: 10.0),
            GradientStatusTag(statusTag: statusTag),
            const Spacer(),
            Row(
              children: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                  label: Text(
                    place.likes.toString(),
                  ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.reply),
                  label: Text(
                    place.shared.toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
