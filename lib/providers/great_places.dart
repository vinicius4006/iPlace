import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recursos_nativos/models/place.dart';
import 'package:recursos_nativos/utils/db_util.dart';
import 'package:recursos_nativos/utils/location_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    String dir = (await getApplicationDocumentsDirectory()).path;
    _items = (dataList.map(
      (item) {
        final imgBytes = base64Decode(item["image"]);
        var file = File("$dir/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            ".jpg");
        file.writeAsBytesSync(imgBytes);
        return Place(
          id: item['id'],
          title: item['title'],
          location: PlaceLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address']),
          image: file,
        );
      },
    )).toList();
    notifyListeners();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    String image64 = base64Encode(await image.readAsBytes());
    final newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(
            latitude: position.latitude,
            longitude: position.longitude,
            address: address),
        image: image);
    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': image64,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address
    });
    notifyListeners();
  }
}
