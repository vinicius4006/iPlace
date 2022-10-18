import 'package:flutter/material.dart';
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
      body: Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
