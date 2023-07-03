import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gp/trip/presentation/controller/trip_cubit.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';
import 'package:gp/trip/presentation/screens/Drivers/Home.dart';
import 'package:location/location.dart'as loc;
import '../home/home.dart';
class LocationPage extends StatefulWidget {
  Widget? backPage;
   LocationPage({Key? key,required this.backPage}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destLocation = LatLng(0, 0);
  bool _isSheetOpen = false;


  List<LatLng> _polylineCoordinates = [];
  loc.LocationData? _currentLocation;

  Future<void> _getCurrentLocation() async {
    loc.Location location = loc.Location();
    _currentLocation = await location.getLocation();
    setState(() {});
    await _getPolylinePoints();
  }

  Future<void> _getPolylinePoints() async {
    PolylinePoints polylinePoint = PolylinePoints();
    PolylineResult result = await polylinePoint.getRouteBetweenCoordinates(
      google_api,
      PointLatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      PointLatLng(destLocation.latitude, destLocation.longitude),
    );


    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    _getPolylinePoints();
    super.initState();
  }
  // void setMyVariable(String x, String y) {
  //   _homePageKey.currentState?.settmyVariable(x, y);
  // }
  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: Platform.localeName);


      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String add = placemark.street ?? '';
        if (placemark.subThoroughfare != null) {
          add = '${placemark.subThoroughfare} $add';
        }
        if (placemark.thoroughfare != null) {
          add = '${placemark.thoroughfare}, $add';
        }
        if (placemark.subLocality != null) {
          add = '$add, ${placemark.subLocality}';
        }
        if (placemark.locality != null) {
          add = '$add, ${placemark.locality}';
        }
        if (placemark.administrativeArea != null) {
          add = '$add, ${placemark.administrativeArea}';
        }
        if (placemark.postalCode != null) {
          add = '$add ${placemark.postalCode}';
        }
        if (placemark.country != null) {
          add = '$add, ${placemark.country}';
        }
        return add;
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<LatLng> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);

        //Create a new Marker object and add it to the _markers set
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId('destination'),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(title: address),
            ),
          );
        });
        return latLng;
      }
    } catch (e) {
      print(e);
    }
    return LatLng(0, 0);
  }
  void _openLocationSheet() async {
    setState(() {
      _isSheetOpen = true;
    });
    loc.LocationData currentLocation =
    await loc.Location().getLocation();
    LatLng currentLatLng = LatLng(
        currentLocation.latitude!, currentLocation.longitude!);
    String currentAddress =
    await _getAddressFromLatLng(currentLatLng);
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: TripCubit.get(context).startAddressController,
                  decoration: InputDecoration(
                    labelText: 'Enter Address',
                    labelStyle: TextStyle(
                      color: Color(0xFF836D9A),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.my_location),
                          onPressed: () async {
                            loc.LocationData currentLocation =
                            await loc.Location().getLocation();
                            LatLng currentLatLng = LatLng(
                                currentLocation.latitude!,
                                currentLocation.longitude!);
                            String currentAddress =
                            await _getAddressFromLatLng(currentLatLng);
                           // TripCubit.get(context).startAddressController.text = currentAddress;
                            TripCubit.get(context).display_date_time(currentAddress, TripCubit.get(context).startAddressController);
                            setState(() {
                              _markers.add(
                                Marker(
                                  markerId: MarkerId('current_location'),
                                  position: currentLatLng,
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                                  infoWindow: InfoWindow(
                                    title: 'Current Location',
                                    snippet: currentAddress,
                                  ),
                                ),
                              );
                            });
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            String address = TripCubit.get(context).startAddressController.text.trim();
                            TripCubit.get(context).display_date_time(address, TripCubit.get(context).startAddressController);

                            if (address.isNotEmpty) {
                              LatLng location =
                              await _getLatLngFromAddress(address);
                              setState(() {
                                _markers.add(
                                  Marker(
                                    markerId: MarkerId('start_location'),
                                    position: location,
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueGreen,
                                    ),
                                    infoWindow: InfoWindow(
                                      title: 'Start Location',
                                      snippet: address,
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _markers.removeWhere(
                              (marker) => marker.markerId.value == 'current_location');
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: TripCubit.get(context).endAddressController,
                  decoration: InputDecoration(
                    labelText: 'Destination Address',
                    labelStyle: TextStyle(
                        color: Color(0xFF836D9A),
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        String address =
                        TripCubit.get(context).endAddressController.text.trim();
                        TripCubit.get(context).display_date_time(address, TripCubit.get(context).endAddressController);

                        if (address.isNotEmpty) {
                          LatLng destinationLatLng =
                          await _getLatLngFromAddress(address);

                          setState(() {
                            _getPolylinePoints();
                          });
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  onSubmitted: (value) async {
                    LatLng destinationLatLng =
                    await _getLatLngFromAddress(value);

                    setState(() {
                      _getPolylinePoints();
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  widget.backPage!));
                  // String S=_startAddressController.text;
                  // String d=_endAddressController.text;

                },
                child: Text('ok'),
              ),
            ],
          ),
        );
      },
    );
  }
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('dest'),
          position: destLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: 'This is the destination location',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripCubit, TripStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF442268),

        title: Text('Location Page'),
      ),
      body: _currentLocation == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          zoom: 14.0,
        ),
        markers: _markers,
        polylines: {
          Polyline(
            polylineId: PolylineId('polyline'),
            color: Colors.blue,
            points: _polylineCoordinates,
          ),
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: FloatingActionButton(

            onPressed: _openLocationSheet,
            tooltip: 'Get Location',
            child: Icon(Icons.add_location),
          ),
        ),
      ),
    );
  },
);
  }
}

const String google_api = "AIzaSyCUYrep7m7CTr3UIfrBdJh3itnbeuKEwM8";