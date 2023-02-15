import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng? lastMapPosition;
  MapType currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  final Set<Marker> tapMarkers = {};
  List<LatLng> list = [];
  static const kGoogleApiKey = "AIzaSyDU8ixiHp9IPRMVAMmndBMEXzZOmxKwYtw";
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  String? location;

  PolylineResult? result;
  double fstLang = 0;
  double lastLang = 0;
  double fstLat = 0;
  double lastLat = 0;
  bool isLast = false;

  permissionHendler() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      openAppSettings();
    }
    if (await Permission.location.isRestricted) {
      Permission.location.request();
    }
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getLiveLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    print(position.longitude);

    fstLat = position.latitude;
    fstLang = position.longitude;
    markerAdd(firstLat: fstLat, firstLng: fstLang, lastLat: lastLat, lastLng: lastLang, title: 'Your Location');

    polyLineCreate(fstLat: fstLat, fstLag: fstLang, lastLat: lastLat, lastLag: lastLang);
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(fstLat, fstLang), zoom: 15),
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    String Address = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    textEditingController.text = Address;
    location = Address;
  }

  Future<void> markerAdd(
      {required double firstLat, required double firstLng, required double lastLat, required double lastLng, required String title}) async {
    _markers.clear();

    _markers.add(Marker(
      markerId: MarkerId(LatLng(firstLat, firstLng).toString()),
      position: LatLng(firstLat, firstLng),
      infoWindow: InfoWindow(
        title: title,
        // snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    _markers.add(Marker(
      markerId: MarkerId(LatLng(lastLat, lastLng).toString()),
      position: LatLng(lastLat, lastLng),
      infoWindow: InfoWindow(
        title: title,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  polyLineCreate({required double fstLat, required double fstLag, required double lastLat, required double lastLag}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    result = await polylinePoints.getRouteBetweenCoordinates(kGoogleApiKey, PointLatLng(fstLat, fstLag), PointLatLng(lastLat, lastLag));

    if (result!.points.isNotEmpty) {
      list.clear();
      for (var element in result!.points) {
        list.add(LatLng(element.latitude, element.longitude));
      }
    } else {}
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissionHendler();
    getLiveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Map"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (latLong) async {
              List<Placemark> placemarks = await placemarkFromCoordinates(latLong.latitude, latLong.longitude);
              print(placemarks);
              Placemark place = placemarks[0];
              String Address = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

              textEditingController1.text = Address;
              setState(() {
                lastLat = latLong.latitude;
                lastLang = latLong.longitude;
                markerAdd(title: "location", lastLng: lastLang, lastLat: lastLat, firstLng: fstLang, firstLat: fstLat);
                polyLineCreate(fstLat: fstLat, fstLag: fstLang, lastLat: lastLat, lastLag: lastLang);

                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: LatLng(lastLat, lastLang), zoom: 15),
                  ),
                );
              });
            },
            onMapCreated: (controller) {
              mapController = controller;
              setState(() {});
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.233885388787453, 72.8636058457404),
              zoom: double.infinity,
            ),
            onCameraMove: (CameraPosition position) {
              lastMapPosition = position.target;
            },
            mapType: currentMapType,
            markers: _markers,
            polylines: {
              Polyline(
                polylineId: const PolylineId('1'),
                consumeTapEvents: true,
                color: Colors.red,
                width: 5,
                points: list,
              )
            },
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(color: Colors.white70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      Prediction? place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'in')],
                        onError: (err) {
                          print(err);
                        },
                      );
                      setState(() {
                        textEditingController.text = place!.description.toString();
                      });

                      GoogleMapsPlaces plist = GoogleMapsPlaces(
                        apiKey: kGoogleApiKey,
                        apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      );
                      String placeId = place?.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeId);
                      final geometry = detail.result.geometry!;

                      setState(() {
                        fstLang = geometry.location.lng;
                        fstLat = geometry.location.lat;
                      });
                      markerAdd(firstLat: fstLat, firstLng: fstLang, lastLat: lastLat, lastLng: lastLang, title: detail.result.name);
                      polyLineCreate(fstLat: fstLat, fstLag: fstLang, lastLat: lastLat, lastLag: lastLang);

                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: LatLng(fstLat, fstLang), zoom: 15),
                        ),
                      );
                    },
                    onChanged: (val) {
                      location = val;
                    },
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Location',
                      labelText: 'Search',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      Prediction? place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'in')],
                        onError: (err) {
                          print(err);
                        },
                      );
                      setState(() {
                        textEditingController1.text = place!.description.toString();
                      });

                      GoogleMapsPlaces plist = GoogleMapsPlaces(
                        apiKey: kGoogleApiKey,
                        apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      );
                      String placeId = place?.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeId);
                      final geometry = detail.result.geometry!;

                      setState(() {
                        lastLang = geometry.location.lng;
                        lastLat = geometry.location.lat;
                      });
                      markerAdd(lastLat: lastLat, lastLng: lastLang, firstLat: fstLat, firstLng: fstLang, title: detail.result.name);
                      polyLineCreate(fstLat: fstLat, fstLag: fstLang, lastLat: lastLat, lastLag: lastLang);

                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: LatLng(lastLat, lastLang), zoom: 15),
                        ),
                      );
                    },
                    onChanged: (val) {
                      location = val;
                    },
                    controller: textEditingController1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Location',
                      labelText: 'Search',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 160, horizontal: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        // currentMapType = currentMapType == MapType.normal ? MapType.satellite : MapType.normal;

                        getLiveLocation();
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    heroTag: 1,
                    child: const Icon(Icons.location_on, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
