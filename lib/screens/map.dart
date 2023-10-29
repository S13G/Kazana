import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:kazana/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422, // Default latitude
      longitude: -122.084, // Default longitude
      address: '', // Default address
    ),
    this.isSelecting = true, // Default isSelecting to true
  });

  final PlaceLocation location; // The location passed to the screen

  final bool isSelecting; // Indicates whether a location is being selected

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation; // Variable to store the selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              // Display different titles based on 'isSelecting'
              Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
          actions: [
            // Display save button only when selecting a location
            if (widget.isSelecting)
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  // Close the screen and return the selected location
                  Navigator.of(context).pop(_pickedLocation);
                },
              ),
          ]),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLocation =
                      position; // Update the selected location on tap
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude, // Initial latitude
            widget.location.longitude, // Initial longitude
          ),
          zoom: 16, // Initial zoom level
        ),
        markers: _pickedLocation == null && widget.isSelecting
            ? {} // No markers when not selecting or if location is not picked
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  // Unique marker ID
                  // Use selected location if available, otherwise use initial location
                  position: _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
