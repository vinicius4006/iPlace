import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recursos_nativos/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;
  const MapScreen(
      {Key? key,
      this.initialLocation =
          const PlaceLocation(latitude: 37.419857, longitude: -122.078827),
      this.isReadOnly = false})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;
  void _selectedPosition(LatLng position) {
    setState(() => _pickedPosition = position);
  }

  @override
  Widget build(BuildContext context) {
    final loc = LatLng(
        widget.initialLocation.latitude, widget.initialLocation.longitude);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione..."),
        actions: [
          if (!widget.isReadOnly && _pickedPosition != null)
            IconButton(
                onPressed: () => _pickedPosition == null
                    ? null
                    : Navigator.pop(context, _pickedPosition),
                icon: Icon(Icons.check_circle))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: loc,
          zoom: 13,
        ),
        myLocationEnabled: true,
        onTap: widget.isReadOnly ? null : _selectedPosition,
        markers: <Marker>{
          Marker(markerId: MarkerId("p1"), position: _pickedPosition ?? loc)
        },
      ),
    );
  }
}
