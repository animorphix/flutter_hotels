import 'package:flutter/material.dart';
import 'package:hotels/models/hotelsModel.dart';

class HotelCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onPressed;
  final List<AmenityDb> amenitiesDB;
  final int stars;

  const HotelCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onPressed,
    required this.price,
    required this.amenitiesDB,
    required this.stars,
  }) : super(key: key);

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool isStarFilled = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> amenityWidgets = [];
    const maxAmenitiesToShow = 3;

    for (int i = 0;
        i < widget.amenitiesDB.length && i < maxAmenitiesToShow;
        i++) {
      amenityWidgets.add(
        Text(
          widget.amenitiesDB[i].name.replaceAll("\n", " "),
          style: const TextStyle(
              fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.w400),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.02),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.image,
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: amenityWidgets,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      widget.stars.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  isStarFilled ? Icons.star : Icons.star_outline,
                ),
                onPressed: () {
                  setState(() {
                    isStarFilled = !isStarFilled;
                  });
                  widget.onPressed();
                },
                splashRadius: 0.001,
                iconSize: 16,
              ),
              Column(
                children: [
                  const Text(
                    "from",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
