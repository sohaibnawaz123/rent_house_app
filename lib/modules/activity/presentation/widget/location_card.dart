import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_address_entity.dart';

class MapCard extends StatefulWidget {
  final AddressEntity? address;
  const MapCard({super.key, this.address});

  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  late LatLng _center;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();

    _center = LatLng(
      widget.address?.lat ?? 24.8607,
      widget.address?.lon ?? 67.0011,
    );

    _markers = {
      Marker(
        markerId: const MarkerId("location"),
        position: _center,
        infoWindow: InfoWindow(
          title: widget.address?.addressline ?? "Location",
          snippet:
              "${widget.address?.addressline}, ${widget.address?.city}, ${widget.address?.country}",
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: _center, zoom: 14),
          markers: _markers,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
