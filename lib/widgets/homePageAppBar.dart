import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String city;
  final DateTime startDate;
  final DateTime endDate;

  HomePageAppBar({
    required this.city,
    required this.startDate,
    required this.endDate,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  @override
  Widget build(BuildContext context) {
    final String formattedStartDate = (formatter.format(startDate)).toString();
    final String formattedEndDate = (formatter.format(endDate)).toString();
    final int nights = endDate.difference(startDate).inDays;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Places to live in $city',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$formattedStartDate - $formattedEndDate ($nights nights)',
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
