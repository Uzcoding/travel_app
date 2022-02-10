import 'package:flutter/material.dart';
import 'package:travel_app_with_animations/models/place.dart';

class PlaceComments extends StatelessWidget {
  const PlaceComments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white70,
          ],
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 60.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade800,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                for (var i = 0; i < 3; i++)
                  Align(
                    widthFactor: .7,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            TravelUser.users[i].urlPhoto,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 10.0),
                const Text(
                  'Comments',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Text(
                  '120',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.blueGrey.shade50,
            ),
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
