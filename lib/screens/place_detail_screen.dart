import 'package:flutter/material.dart';

import 'package:travel_app_with_animations/models/place.dart';
import 'package:travel_app_with_animations/theme/text_theme_x.dart';
import 'package:travel_app_with_animations/widgets/animated_detail_header.dart';
import 'package:travel_app_with_animations/widgets/place_comments.dart';
import 'package:travel_app_with_animations/widgets/translate_animation.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({
    Key? key,
    required this.place,
    required this.screenHeight,
  }) : super(key: key);

  final TravelPlace place;
  final double screenHeight;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late ScrollController _controller;
  late ValueNotifier<double> bottomPercentNotifier;
  bool _isAnimationScroll = false;

  void _scrollListener() {
    var percent =
        _controller.position.pixels / MediaQuery.of(context).size.height;
    bottomPercentNotifier.value = (percent / .3).clamp(0.0, 1.0);
  }

  void _isScrollingListener() {
    var percent = _controller.position.pixels / widget.screenHeight;
    if (!_controller.position.isScrollingNotifier.value) {
      if (percent < .3 && percent > .1) {
        setState(() => _isAnimationScroll = true);
        _controller
            .animateTo(
              widget.screenHeight * .3,
              duration: kThemeAnimationDuration,
              curve: Curves.decelerate,
            )
            .then((value) => setState(() => _isAnimationScroll = false));
      }
      if (percent < .1 && percent > 0) {
        setState(() => _isAnimationScroll = true);
        _controller
            .animateTo(
              0,
              duration: kThemeAnimationDuration,
              curve: Curves.decelerate,
            )
            .then((value) => setState(() => _isAnimationScroll = false));
      }
      if (percent < .5 && percent > .3) {
        setState(() => _isAnimationScroll = true);
        _controller
            .animateTo(
              widget.screenHeight * .3,
              duration: kThemeAnimationDuration,
              curve: Curves.decelerate,
            )
            .then((value) => setState(() => _isAnimationScroll = false));
      }
    }
  }

  @override
  void initState() {
    _controller =
        ScrollController(initialScrollOffset: widget.screenHeight * .3);
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.position.isScrollingNotifier
          .addListener(_isScrollingListener);
    });
    bottomPercentNotifier = ValueNotifier(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isAnimationScroll,
            child: CustomScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  delegate: _BuilderPersistentDelegate(
                    maxExtent: MediaQuery.of(context).size.height,
                    minExtent: 240,
                    builder: (percent) {
                      final bottomPercent = (percent / .3).clamp(0.0, 1.0);

                      return AnimatedDetailHeader(
                        place: widget.place,
                        topPercent: ((1 - percent) / .7).clamp(0.0, 1.0),
                        bottomPercent: bottomPercent,
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: TranslateAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                color: Colors.black26,
                              ),
                              Flexible(
                                child: Text(
                                  widget.place.locationDesc,
                                  style: context.bodyText1.copyWith(
                                    color: Colors.blue,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Text(widget.place.description),
                          const SizedBox(height: 10.0),
                          Text(widget.place.description),
                          const SizedBox(height: 10.0),
                          Text(widget.place.description),
                          const SizedBox(height: 20.0),
                          const Text(
                            'PLACES IN THIS COLLECTION',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemExtent: 150.0,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: TravelPlace.collectionPlaces.length,
                      itemBuilder: (context, index) {
                        final collectionPlace =
                            TravelPlace.collectionPlaces[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              collectionPlace.imagesUrl.first,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 150.0),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: bottomPercentNotifier,
            builder: (context, value, child) {
              return Positioned.fill(
                top: null,
                bottom: -130 * (1 - value),
                child: child!,
              );
            },
            child: const PlaceComments(),
          ),
        ],
      ),
    );
  }
}

class _BuilderPersistentDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;
  _BuilderPersistentDelegate({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
