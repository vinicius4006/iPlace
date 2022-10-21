import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recursos_nativos/providers/great_places.dart';
import 'package:recursos_nativos/widgets/image_input.dart';
import 'package:recursos_nativos/widgets/location_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() => _pickedImage = pickedImage);
  }

  void _selectPosition(LatLng position) {
    setState(() => _pickedPosition = position);
  }

  bool _isValidForm() {
    return _titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedPosition == null;
  }

  void _submitForm() {
    if (_isValidForm()) return;

    context
        .read<GreatPlaces>()
        .addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo Lugar'),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                            aspectRatio: 5 / 1,
                            child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                    label: Text('Título')))),
                        ImageInput(
                          onselectImage: _selectImage,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: LocationInput(
                              onSelectedPosition: this._selectPosition),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.black,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0,
                      minimumSize: const Size(50, 50)),
                  onPressed: !_isValidForm() ? _submitForm : null,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text('Adicionar'))
            ],
          ),
        ));
  }
}
