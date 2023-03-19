// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../Models/Cinema/cinema.dart';

// class CinemasPage extends StatefulWidget {
//   @override
//   State<CinemasPage> createState() => CinemasPageState();
// }

// class CinemasPageState extends State<CinemasPage> {
//   final Map<String, Marker> _markers = {};
//   late CameraPosition _currentCameraPosition;
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _initialCamera = CameraPosition(
//     target: LatLng(0, 0),
//     zoom: 1,
//   );
//   late String _mapStyle;

//   final String googlePlacesApiKey = 'AIzaSyDwhd69HSro0OBP_5xbSrAQ0EDI0pGtxCU';
//   late PlacesService _placesService;

//   @override
//   void initState() {
//     _placesService = PlacesService(googlePlacesApiKey);
//     _requestLocationPermission();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cinemas nearby"),
//       ),
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//             myLocationButtonEnabled: false,
//             initialCameraPosition: _initialCamera,
//             markers: _markers.values.toSet(),
//           ),
//         ],
//       ),
//     );
//   }

//   _getUserLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     if (position != null) {
//       _addUserMarker(position);
//       try {
//         List<Place> cinemas = await _placesService.getNearbyCinemas(position);
//         _addCinemasToMap(cinemas);
//       } catch (e) {
//         // Handle error in fetching cinemas
//         print(e);
//       }
//     } else {
//       // Handle location fetching error
//     }
//   }

//   _addUserMarker(Position position) async {
//     _currentCameraPosition = CameraPosition(
//         target: LatLng(position.latitude, position.longitude), zoom: 13);
//     final GoogleMapController controller = await _controller.future;
//     controller
//         .moveCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
//     final marker = Marker(
//       markerId: MarkerId('user'),
//       infoWindow: InfoWindow(title: 'Me'),
//       zIndex: 1.0,
//       position: LatLng(position.latitude, position.longitude),
//     );
//     setState(() {
//       if (_markers.containsKey('user')) {
//         _markers.remove('user');
//       }
//       _markers['user'] = marker;
//     });
//   }

//   _addCinemasToMap(List<Place> cinemas) {
//     List<Marker> newMarkers = [];
//     for (var cinema in cinemas) {
//       Marker m = Marker(
//         markerId: MarkerId(cinema.id),
//         infoWindow: InfoWindow(title: cinema.name),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//         position: LatLng(cinema.lat, cinema.lng),
//       );
//       newMarkers.add(m);
//     }
//     setState(() {
//       for (var m in newMarkers) {
//         if (_markers.containsKey(m.markerId.value)) {
//           _markers.remove(m.markerId.value);
//           _markers[m.markerId.value];
//                 _markers[m.markerId.value] = m;
//         }
//       }
//     });

//     _requestLocationPermission() async {
//     PermissionStatus status = await Permission.locationWhenInUse.request();
//     if (status.isGranted) {
//       _getUserLocation();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Location Permission Denied'),
//             content: Text('Please grant location access to find nearby cinemas.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }



