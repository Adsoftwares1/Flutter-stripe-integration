import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHome extends StatefulWidget {
  const GoogleMapHome({super.key});

  @override
  State<GoogleMapHome> createState() => _GoogleMapHomeState();
}

class _GoogleMapHomeState extends State<GoogleMapHome> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.0109, 71.4804),
    zoom: 5.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      target: LatLng(37.43296265331129, -122.08832357078792),
      zoom: 19.151926040649414);

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(34.025917, 71.560135), // San Francisco coordinates
      infoWindow: InfoWindow(
        title: 'San Francisco',
        snippet: 'A nice city',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_2'),
      position: LatLng(34.0204, 71.4822), // Los Angeles coordinates
      infoWindow: InfoWindow(
        title: 'Los Angeles',
        snippet: 'City of Angels',
      ),
    ),
    Marker(
        markerId: MarkerId("3"),
        position: LatLng(34.0250, 71.4830),
        infoWindow: InfoWindow(title: "Mujeeb", snippet: "Hangu")),
    Marker(
        markerId: MarkerId("4"),
        position: LatLng(37.43296265331129, -122.08832357078792),
        infoWindow: InfoWindow(title: "Mujeeb", snippet: "Hangu")),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
