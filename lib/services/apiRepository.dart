import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/hotelsModel.dart';

var apiKey = dotenv.env['API_KEY']!;
//var url ='https://k106555.hostde21.fornex.host/v1/test_api.php?key=getHotels&apiKey=$apiKey';
var url =
    'https://k106555.hostde21.fornex.host/v1/getData.php?key=getHotels&apikey=b7ec14673551cb16d3229b4de72bb5a5&iata=MOW&checkIn=2023-08-03&checkOut=2023-08-10&adultsCount=2&customerIP=185.119.1.126';

Future<List<Result>> fetchHotels() async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body);
      final results = jsonResult['data']['result'];

      List<Result> resultList = results
          .map<Result>((resultJson) => Result.fromJson(resultJson))
          .toList();

      return resultList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server');
  }
}
