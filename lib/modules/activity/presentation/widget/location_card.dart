import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCard extends StatefulWidget {
  const MapCard({super.key});

  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  final LatLng _center = const LatLng(24.8607, 67.0011);
  late Set<Marker> _markers;
  @override
  void initState() {
    super.initState();

    _markers = {
      Marker(
        markerId: const MarkerId("karachi"),
        position: _center,
        infoWindow: const InfoWindow(title: "Karachi", snippet: "My Location"),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,

      // margin: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center, // Karachi
                zoom: 14,
              ),
              markers: _markers,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),

            // // Overlay Card Content
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   right: 10,
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(
            //           "Karachi Location",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Text("Tap to view details"),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
