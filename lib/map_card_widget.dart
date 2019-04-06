import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCardWidget extends StatefulWidget {
  final LatLng location;
  final String title;
  final String address;

  const MapCardWidget({Key key, this.location, this.title, this.address})
      : super(key: key);

  @override
  _MapStatefulState createState() => _MapStatefulState();
}

class _MapStatefulState extends State<MapCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(child: Row(children: [_mapView(), _infoListTile()]));
  }

  _mapView() {
    return Container(
      child: SizedBox(width: 120.0, height: 120.0, child: _mapObject()),
    );
  }

  GoogleMap _mapObject() {
    final CameraPosition _camPosition =
        CameraPosition(target: widget.location, zoom: 14.0);

    String markerIdVal = widget.location.latitude.toString() +
        widget.location.longitude.toString();

    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
        markerId: markerId, consumeTapEvents: true, position: widget.location);

    final Map<MarkerId, Marker> markersMap = {markerId: marker};

    bool _compassEnabled = false;
    CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
    MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
    MapType _mapType = MapType.normal;
    bool _rotateGesturesEnabled = false;
    bool _scrollGesturesEnabled = false;
    bool _tiltGesturesEnabled = false;
    bool _zoomGesturesEnabled = false;
    bool _myLocationEnabled = false;

    return GoogleMap(
      markers: Set<Marker>.of(markersMap.values),
      initialCameraPosition: _camPosition,
      compassEnabled: _compassEnabled,
      cameraTargetBounds: _cameraTargetBounds,
      minMaxZoomPreference: _minMaxZoomPreference,
      mapType: _mapType,
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      myLocationEnabled: _myLocationEnabled,
    );
  }

  _infoListTile() {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text("${widget.title}"),
          subtitle: Text("${widget.address}"),
        ),
        ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              Container(
                height: 10,
                child: FlatButton(
                  child: const Text('DIRECTIONS'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
