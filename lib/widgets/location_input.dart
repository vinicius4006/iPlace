import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:recursos_nativos/utils/location_util.dart';
import 'package:recursos_nativos/views/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPosition;
  const LocationInput({super.key, required this.onSelectedPosition});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    setState(() => _previewImageUrl = staticMapImageUrl);
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectedPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      debugPrint('motivo erro getCurrentuserLocation: $e');
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true, builder: (ctx) => const MapScreen()));

    _showPreview(selectedPosition!.latitude, selectedPosition.longitude);
    widget.onSelectedPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                style: TextButton.styleFrom(
                    textStyle:
                        TextStyle(color: Theme.of(context).primaryColor)),
                icon: const Icon(Icons.location_on),
                label: const Text('Localização Atual')),
            TextButton.icon(
                onPressed: _selectOnMap,
                style: TextButton.styleFrom(
                    textStyle:
                        TextStyle(color: Theme.of(context).primaryColor)),
                icon: const Icon(Icons.map),
                label: const Text('Selecione no Mapa')),
          ],
        )
      ],
    );
  }
}
