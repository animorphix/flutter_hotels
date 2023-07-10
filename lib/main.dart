import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotels/models/hotelsModel.dart';
import 'package:hotels/services/apiRepository.dart';
import 'package:hotels/widgets/homePageAppBar.dart';
import 'package:hotels/widgets/hotelCard.dart';
import './models/tempHotelImages.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Result>> _resultFuture;
  List<String> hotelImageList = hotelImages;

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
                final results = snapshot.data;
                return ListView.builder(
                  itemCount: results?.length,
                  itemBuilder: (context, index) {
                    return HotelCard(
                      image: hotelImages[index],
                      title: results![index].name.replaceAll("\n", " "),
                      onPressed: onPressed,
                      price: results[index].price.toString(),
                      amenitiesDB: results[index].amenityDb,
                      stars: results[index].stars,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
