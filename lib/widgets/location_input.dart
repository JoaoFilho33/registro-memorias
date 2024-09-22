import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});

  final Function(LatLng location) onSelectedLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  LatLng? _pickedLocation;
  bool _isGettingLocation = false;
  late GoogleMapController _mapController;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat != null && lng != null) {
      _saveLocation(LatLng(lat, lng));
    }
  }

  void _saveLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
      _isGettingLocation = false;
    });
    widget.onSelectedLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          child: _isGettingLocation
              ? const CircularProgressIndicator()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _pickedLocation ?? LatLng(37.7749, -122.4194), // Localização padrão (São Francisco)
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  onTap: (LatLng position) {
                    _saveLocation(position);
                  },
                  markers: _pickedLocation != null
                      ? {
                          Marker(
                            markerId: MarkerId('m1'),
                            position: _pickedLocation!,
                          )
                        }
                      : {},
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text("Obter Localização Atual"),
              icon: const Icon(Icons.location_on),
            ),
          ],
        ),
      ],
    );
  }
}
