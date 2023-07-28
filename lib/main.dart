import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotels/models/hotelsModel.dart';
import 'package:hotels/services/apiRepository.dart';
import 'package:hotels/widgets/homePageAppBar.dart';
import 'package:hotels/widgets/hotelCard.dart';
import './models/tempHotelImages.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Result>> _resultFuture;
  List<String> hotelImageList = hotelImages;
  Set<String> selectedFilters = {};
  bool sortByPrice = true;

  @override
  void initState() {
    _resultFuture = fetchHotels();
    super.initState();
  }

  void onPressed() {}

  Future<void> _refreshData() async {
    // Fetch the updated data
    List<Result> updatedData = await fetchHotels();
    setState(() {
      // Update the data source
      _resultFuture = Future.value(updatedData);
    });
  }

  List<Result> filterResults(
      List<Result> results, List<String> selectedFilters) {
    if (selectedFilters.isEmpty) {
      // If no filters selected, return all results
      return results;
    }

    final filtersMap = {
      'Card Required': (Options options) => options.cardRequired == true,
      'Deposit': (Options options) => options.deposit == true,
      'Refundable': (Options options) => options.refundable == true,
      // Add more conditions for other filters if needed
    };

    return results.where((result) {
      final room = filterRoomsByPrice(result.rooms);
      final options = room.options;
      return selectedFilters.every((filter) {
        final filterFunc = filtersMap[filter];
        return filterFunc != null ? filterFunc(options) : true;
      });
    }).toList();
  }

  Room filterRoomsByPrice(List<Room> rooms) {
    Room result = rooms[0];
    var price = rooms[0].price;
    for (var room in rooms) {
      if (room.price < price) {
        price = room.price;
        result = room;
      }
    }
    return result;
  }

  List<Result> sortResultsByPrice(List<Result> results) {
    results.sort((a, b) => a.minPriceTotal.compareTo(b.minPriceTotal));
    return results;
  }

  List<Result> sortResultsByPopularity(List<Result> results) {
    results.sort((a, b) => b.popularity.compareTo(a.popularity));
    return results;
  }

  List<Result> sortResults(List<Result> results) {
    if (sortByPrice) {
      return sortResultsByPrice(results);
    } else {
      return sortResultsByPopularity(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(
        city: 'Berlin, Germany',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 5)),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            FilterChipGroup(
              filterChips: [
                'Card Required',
                'Deposit',
                'Refundable',
                // Add more filter chips here if needed
              ],
              selectedFilters: selectedFilters,
              onFilterSelected: (selected) {
                setState(() {
                  selectedFilters = selected;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            FilterChip(
              label: Text(
                sortByPrice ? 'Sorted by Price' : 'Sorted by Popularity',
                style: TextStyle(color: Colors.white),
              ),
              selected: false,
              onSelected: (selected) {
                setState(() {
                  sortByPrice = !sortByPrice;
                });
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<Result>>(
                  future: _resultFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: \n ${snapshot.error}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    } else {
                      final filteredResults = filterResults(
                          snapshot.data!, selectedFilters.toList());
                      final sortedResults = sortResults(filteredResults);
                      return ListView.builder(
                        itemCount: sortedResults.length,
                        itemBuilder: (context, index) {
                          return HotelCard(
                            image: hotelImages[index],
                            title:
                                sortedResults[index].name.replaceAll("\n", " "),
                            onPressed: onPressed,
                            price:
                                sortedResults[index].minPriceTotal.toString(),
                            amenitiesDB: sortedResults[index].amenityDb,
                            stars: sortedResults[index].stars,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipGroup extends StatelessWidget {
  final List<String> filterChips;
  final Set<String> selectedFilters;
  final Function(Set<String> selected) onFilterSelected;

  const FilterChipGroup({
    required this.filterChips,
    required this.selectedFilters,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 18,
      children: filterChips.map((chipLabel) {
        final isSelected = selectedFilters.contains(chipLabel);
        return FilterChip(
          selected: isSelected,
          label: Text(
            chipLabel,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          onSelected: (selected) {
            Set<String> updatedSelectedFilters = Set.from(selectedFilters);
            if (selected) {
              updatedSelectedFilters.add(chipLabel);
            } else {
              updatedSelectedFilters.remove(chipLabel);
            }
            onFilterSelected(updatedSelectedFilters);
          },
          selectedColor: Colors.blue,
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 2,
            ),
          ),
          showCheckmark: false, // Hide the checkmark for selected chips
        );
      }).toList(),
    );
  }
}
