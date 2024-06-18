import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapView extends StatefulWidget {
  final String accessToken;
  MapView({required this.accessToken});
  @override
  _MapState createState() => _MapState(accessToken: accessToken);
}

class _MapState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(51.107883, 17.038538);
  ValueNotifier<Set<Marker>> _markersNotifier = ValueNotifier<Set<Marker>>({});
  String accessToken;
  _MapState({required this.accessToken});

  @override
  void initState() {
    super.initState();
    _fetchPoints();
  }

  Future<void> _fetchPoints() async {
    final String apiUrl = 'https://psiim-82a14bc94a7d.herokuapp.com/api/pois';
    final String token = accessToken;

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Data received: $data');

        Set<Marker> markers = data.map((point) {
          print('Adding marker: $point');
          return Marker(
            markerId:
                MarkerId(point['id'].toString()), // Use a unique identifier
            position: LatLng(point['lat'] as double, point['lon'] as double),
            infoWindow: InfoWindow(
              title: point['name'] ?? '',
              snippet: point['description'] ?? '',
            ),
            icon: BitmapDescriptor.defaultMarker,
          );
        }).toSet();

        print('Markers list: $markers');
        _markersNotifier.value = markers;
      } else {
        throw Exception('Failed to fetch points: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder<Set<Marker>>(
            valueListenable: _markersNotifier,
            builder: (context, markers, _) {
              return GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _center, zoom: 11),
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              );
            },
          ),
          Positioned(
            top: 60.0,
            left: 40.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
