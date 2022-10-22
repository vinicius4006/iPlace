import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recursos_nativos/providers/great_places.dart';
import 'package:recursos_nativos/utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Lugares'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.PLACE_FORM),
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
            future: context.read<GreatPlaces>().loadPlaces(),
            builder: (ctx, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Nenhum local cadastrado'),
                    ),
                    builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount ==
                            0
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                      greatPlaces.itemByIndex(i).image,
                                    ),
                                  ),
                                  title: Text(greatPlaces.itemByIndex(i).title),
                                  subtitle: Text(greatPlaces
                                      .itemByIndex(i)
                                      .location
                                      .address),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.PLACE_DETAIL,
                                        arguments: greatPlaces.itemByIndex(i));
                                  },
                                )),
                  )));
  }
}
