import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recursos_nativos/providers/great_places.dart';
import 'package:recursos_nativos/utils/app_routes.dart';
import 'package:recursos_nativos/views/place_form_screen.dart';
import 'package:recursos_nativos/views/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData();
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: themeData.copyWith(
            colorScheme: themeData.colorScheme
                .copyWith(primary: Colors.indigo, secondary: Colors.amber)),
        home: const PlacesListScreen(),
        routes: {AppRoutes.PLACE_FORM: (_) => const PlaceFormScreen()},
      ),
    );
  }
}
