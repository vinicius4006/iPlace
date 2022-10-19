import 'dart:io';

import 'package:flutter/material.dart';
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

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    context.read<GreatPlaces>().addPlace(_titleController.text, _pickedImage!);

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
                        const AspectRatio(
                          aspectRatio: 1,
                          child: LocationInput(),
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
                  onPressed: _submitForm,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text('Adicionar'))
            ],
          ),
        ));
  }
}
