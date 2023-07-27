// To parse this JSON data, do
//
//     final hotels = hotelsFromJson(jsonString);

import 'dart:convert';

Hotels hotelsFromJson(String str) => Hotels.fromJson(json.decode(str));

String hotelsToJson(Hotels data) => json.encode(data.toJson());

class Hotels {
  List<Result> result;

  Hotels({
    required this.result,
  });

  factory Hotels.fromJson(Map<String, dynamic> json) => Hotels(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  List<int> amenities;
  int rating;
  int guestScore;
  int price;
  List<Room> rooms;
  String fullUrl;
  String address;
  Location location;
  int minPriceTotal;
  int stars;
  int photoCount;
  String name;
  double distance;
  int maxPricePerNight;
  String url;
  int maxPrice;
  int id;
  int popularity;
  List<int> photoId;
  List<AmenityDb> amenityDb;

  Result({
    required this.amenities,
    required this.rating,
    required this.guestScore,
    required this.price,
    required this.rooms,
    required this.fullUrl,
    required this.address,
    required this.location,
    required this.minPriceTotal,
    required this.stars,
    required this.photoCount,
    required this.name,
    required this.distance,
    required this.maxPricePerNight,
    required this.url,
    required this.maxPrice,
    required this.id,
    required this.popularity,
    required this.photoId,
    required this.amenityDb,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        amenities: List<int>.from(json["amenities"].map((x) => x)),
        rating: json["rating"],
        guestScore: json["guestScore"],
        price: json["price"],
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        fullUrl: json["fullUrl"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        minPriceTotal: json["minPriceTotal"],
        stars: json["stars"],
        photoCount: json["photoCount"],
        name: json["name"],
        distance: json["distance"]?.toDouble(),
        maxPricePerNight: json["maxPricePerNight"],
        url: json["url"],
        maxPrice: json["maxPrice"],
        id: json["id"],
        popularity: json["popularity"],
        //photosByRoomType: json["photosByRoomType"],
        photoId: List<int>.from(json["photoId"].map((x) => x)),
        amenityDb: List<AmenityDb>.from(
            json["amenitieDB"].map((x) => AmenityDb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "amenitys": List<dynamic>.from(amenities.map((x) => x)),
        "rating": rating,
        "guestScore": guestScore,
        "price": price,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "fullUrl": fullUrl,
        "address": address,
        "location": location.toJson(),
        "minPriceTotal": minPriceTotal,
        "stars": stars,
        "photoCount": photoCount,
        "name": name,
        "distance": distance,
        "maxPricePerNight": maxPricePerNight,
        "url": url,
        "maxPrice": maxPrice,
        "id": id,
        "popularity": popularity,
        "photoId": List<dynamic>.from(photoId.map((x) => x)),
        "amenitieDB": List<dynamic>.from(amenityDb.map((x) => x.toJson())),
      };
}

class AmenityDb {
  String id;
  String name;
  String groupName;

  AmenityDb({
    required this.id,
    required this.name,
    required this.groupName,
  });

  factory AmenityDb.fromJson(Map<String, dynamic> json) => AmenityDb(
        id: json["id"],
        name: json["name"],
        groupName: json["groupName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "groupName": groupName,
      };
}

class Location {
  double lat;
  double lon;

  Location({
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Room {
  Options options;
  String desc;
  int tax;
  String agencyName;
  String? internalTypeId;
  String bookingUrl;
  int price;
  String agencyId;
  int total;
  String type;
  String fullBookingUrl;

  Room({
    required this.options,
    required this.desc,
    required this.tax,
    required this.agencyName,
    this.internalTypeId,
    required this.bookingUrl,
    required this.price,
    required this.agencyId,
    required this.total,
    required this.type,
    required this.fullBookingUrl,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        options: Options.fromJson(json["options"]),
        desc: json["desc"],
        tax: json["tax"],
        agencyName: json["agencyName"],
        internalTypeId: json["internalTypeId"],
        bookingUrl: json["bookingURL"],
        price: json["price"],
        agencyId: json["agencyId"],
        total: json["total"],
        type: json["type"],
        fullBookingUrl: json["fullBookingURL"],
      );

  Map<String, dynamic> toJson() => {
        "options": options.toJson(),
        "desc": desc,
        "tax": tax,
        "agencyName": agencyName,
        "internalTypeId": internalTypeId,
        "bookingURL": bookingUrl,
        "price": price,
        "agencyId": agencyId,
        "total": total,
        "type": type,
        "fullBookingURL": fullBookingUrl,
      };
}

class Options {
  int? available;
  Beds? beds;
  bool deposit;
  bool cardRequired;
  bool? fullBoard;
  bool? ultraAllInclusive;
  bool? allInclusive;
  bool? breakfast;
  bool? halfBoard;
  bool? refundable;

  Options({
    this.available,
    this.beds,
    required this.deposit,
    required this.cardRequired,
    this.fullBoard,
    this.ultraAllInclusive,
    this.allInclusive,
    this.breakfast,
    this.halfBoard,
    this.refundable,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        available: json["available"],
        beds: json["beds"] == null ? null : Beds.fromJson(json["beds"]),
        deposit: json["deposit"],
        cardRequired: json["cardRequired"],
        fullBoard: json["fullBoard"],
        ultraAllInclusive: json["ultraAllInclusive"],
        allInclusive: json["allInclusive"],
        breakfast: json["breakfast"],
        halfBoard: json["halfBoard"],
        refundable: json["refundable"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "beds": beds?.toJson(),
        "deposit": deposit,
        "cardRequired": cardRequired,
        "fullBoard": fullBoard,
        "ultraAllInclusive": ultraAllInclusive,
        "allInclusive": allInclusive,
        "breakfast": breakfast,
        "halfBoard": halfBoard,
        "refundable": refundable,
      };
}

class Beds {
  int? bedsDouble;
  int? twin;

  Beds({
    this.bedsDouble,
    this.twin,
  });

  factory Beds.fromJson(Map<String, dynamic> json) => Beds(
        bedsDouble: json["double"],
        twin: json["twin"],
      );

  Map<String, dynamic> toJson() => {
        "double": bedsDouble,
        "twin": twin,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
