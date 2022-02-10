import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:travel_app_with_animations/models/place.dart';
import 'package:travel_app_with_animations/models/travel_navigation_bar_item.dart';
import 'package:travel_app_with_animations/widgets/place_card.dart';
import 'package:travel_app_with_animations/widgets/travel_navigation_bar.dart';

import 'place_detail_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: IconButton(
          onPressed: () {},
          splashRadius: 25.0,
          icon: const Icon(CupertinoIcons.search),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 25.0,
            icon: const Icon(CupertinoIcons.star),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: TravelPlace.places.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, kToolbarHeight + 20),
        itemExtent: 350,
        itemBuilder: (context, index) {
          final place = TravelPlace.places[index];
          return Hero(
            tag: place.id,
            child: Material(
              child: PlaceCard(
                place: place,
                onTapped: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: PlaceDetailScreen(
                            place: place,
                            screenHeight: MediaQuery.of(context).size.height,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
      bottomNavigationBar: TravelNavigationBar(
        onTap: (value) {},
        items: [
          TravelNavigationBarItem(
            icon: CupertinoIcons.chat_bubble,
            selectedIcon: CupertinoIcons.chat_bubble_fill,
          ),
          TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill,
          ),
        ],
      ),
    );
  }
}
