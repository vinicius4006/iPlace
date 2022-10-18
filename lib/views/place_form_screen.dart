import 'package:flutter/material.dart';
import 'package:recursos_nativos/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();

  void _submitForm() {
    debugPrint('HELLO');
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
                        const ImageInput()
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
