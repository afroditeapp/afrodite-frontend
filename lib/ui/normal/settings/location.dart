

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/profile/location.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.pageLocationTitle)),
      body: locationPage(context),
    );
  }

  Widget locationPage(BuildContext context) {
    final profileLocation = context.read<LocationBloc>().state;
    final profileLocationLatLng = LatLng(profileLocation.latitude, profileLocation.longitude);
    return LocationWidget(
      mode: MapMode.selectLocation,
      handler: LocationUploader(),
      markerInitialLocation: profileLocationLatLng,
      editingHelpText: context.strings.map_select_location_help_text,
    );
  }
}

enum MapMode {
  selectInitialLocation,
  selectLocation,
}

class LocationUploader extends SelectedLocationHandler {
  bool locationUploadInProgress = false;

  @override
  Future<void> handleLocationSelection({
    required BuildContext context,
    required LatLng location,
    required void Function() onStart,
    required void Function(bool) onComplete
  }) async {
    if (locationUploadInProgress) {
      return;
    }

    locationUploadInProgress = true;
    onStart();
    final apiLocation = Location(latitude: location.latitude, longitude: location.longitude);
    final result = await ProfileRepository.getInstance().updateLocation(apiLocation);
    locationUploadInProgress = false;
    onComplete(result);
    // User might have navigated away from the map, so use R class for strings.
    if (result) {
      showSnackBar(R.strings.map_location_update_successful);
    } else {
      showSnackBar(R.strings.map_location_update_failed);
    }
  }
}

class LocationWidget extends StatefulWidget {
  final MapMode mode;
  final LatLng? markerInitialLocation;
  final SelectedLocationHandler handler;
  final String? editingHelpText;
  const LocationWidget({
    required this.mode,
    required this.handler,
    this.markerInitialLocation,
    this.editingHelpText,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

enum MapModeInternal {
  selectLocationNoModeButton,
  selectLocation,
  viewLocation,
  viewLocationEditButtonDisabled,
}

class _LocationWidgetState extends State<LocationWidget> with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late final SelectedLocationHandler _locationSelectedHandler;
  MapAnimationManager? _animationManager = MapAnimationManager();
  LatLng? _profileLocationMarker;
  LatLng? _deviceLocationMarker;
  MapModeInternal _internalMode = MapModeInternal.selectLocation;

  @override
  void initState() {
    super.initState();
    _locationSelectedHandler = widget.handler;
    _profileLocationMarker = widget.markerInitialLocation;
    _animationManager?.init(_mapController, this);
    switch (widget.mode) {
      case MapMode.selectInitialLocation: {
        _internalMode = MapModeInternal.selectLocationNoModeButton;
      }
      case MapMode.selectLocation: {
        _internalMode = MapModeInternal.viewLocation;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bounds = LatLngBounds(
      const LatLng(75, 12),
      const LatLng(50, 40),
    );

    final LatLng initialLocation;
    final double initialZoom;

    final locationLatLng = _profileLocationMarker ?? const LatLng(0, 0);
    if (bounds.contains(locationLatLng)) {
      initialLocation = locationLatLng;
      initialZoom = 10;
    } else {
      initialLocation = const LatLng(61, 24.5);
      initialZoom = 6;
    }

    final initialMap = FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: initialLocation,
        initialZoom: initialZoom,
        minZoom: 4,
        maxZoom: 15,
        cameraConstraint: CameraConstraint.contain(bounds: bounds),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onTap: (tapPosition, point) {
          handleOnTap(context, point);
        },
        onLongPress: (tapPosition, point) {
          handleOnTap(context, point);
        }
      ),
      children: [
        TileLayer(
          maxNativeZoom: 13,
          tileProvider: CustomTileProvider(),
        ),
        markerLayer(),
        attributionWidget(context),
        floatingActionButtons(),
        viewHelp(),
      ],
    );

    return initialMap;
  }

  void handleOnTap(BuildContext context, LatLng point) {
    switch (_internalMode) {
      case MapModeInternal.selectLocationNoModeButton || MapModeInternal.selectLocation:
        _locationSelectedHandler.handleLocationSelection(
          context: context,
          location: point,
          onStart: () {
            if (mounted) {
              setState(() {
                _profileLocationMarker = point;
                _internalMode = MapModeInternal.viewLocationEditButtonDisabled;
              });
            }
          },
          onComplete: (result) {
            if (mounted) {
              setState(() {
                _internalMode = MapModeInternal.viewLocation;
              });
            }
          },
        );
      case MapModeInternal.viewLocation || MapModeInternal.viewLocationEditButtonDisabled: {}
    }
  }

  Widget? modeButton() {
    switch (_internalMode) {
      case MapModeInternal.selectLocationNoModeButton:
        return null;
      case MapModeInternal.selectLocation:
        return FloatingActionButton(
          onPressed: () {
            setState(() {
              _internalMode = MapModeInternal.viewLocation;
            });
          },
          child: const Icon(Icons.check),
        );
      case MapModeInternal.viewLocation || MapModeInternal.viewLocationEditButtonDisabled: {
        void Function()? editButtonAction;
        if (_internalMode == MapModeInternal.viewLocation) {
          editButtonAction = () {
            setState(() {
              _internalMode = MapModeInternal.selectLocation;
            });
          };
        }

        return FloatingActionButton(
          onPressed: editButtonAction,
          child: const Icon(Icons.edit),
        );
      }
    }
  }

  Widget viewHelp() {
    final helpTextString = widget.editingHelpText;
    if (helpTextString == null) {
      return Container();
    }

    final helpText = Text(helpTextString);

    switch (_internalMode) {
      case MapModeInternal.selectLocationNoModeButton || MapModeInternal.selectLocation:
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 15.0,
                  color: Colors.black45,
                )],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: helpText,
            ),
          ),
        );
      case MapModeInternal.viewLocation || MapModeInternal.viewLocationEditButtonDisabled:
        return Container();
    }
  }

  Widget floatingActionButtons() {
    final List<Widget> buttons = [];

    final Widget? modeButton = this.modeButton();
    if (modeButton != null) {
      buttons.add(modeButton);
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: buttons,
        ),
      ),
    );
  }

  Widget markerLayer() {
    const dotSize = 30.0;
    const blueDot = Icon(
      Icons.circle,
      color: Colors.lightBlue,
      size: dotSize - 10,
    );
    const whiteDot = Icon(
      Icons.circle,
      color: Colors.white,
      size: dotSize,
      shadows: [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black87,
          offset: Offset(0.0, 0.0),
        ),
      ],
    );

    const dot = Stack(
      children: [
        Center(child: whiteDot),
        Center(child: blueDot),
      ],
    );

    final markers = List<Marker>.empty(growable: true);
    final currentLocation = _deviceLocationMarker;
    if (currentLocation != null) {
      markers.add(Marker(
        width: dotSize,
        height: dotSize,
        point: currentLocation,
        alignment: Alignment.center,
        child: dot,
      ));
    }

    const locationSize = 70.0;
    final profileLocation = _profileLocationMarker;
    if (profileLocation != null) {
      markers.add(Marker(
        width: locationSize,
        height: locationSize,
        point: profileLocation,
        alignment: Alignment.topCenter,
        child: const Icon(
          Icons.location_on,
          color: Colors.lightBlue,
          size: locationSize,
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.black,
              offset: Offset(0.0, 0.0),
            ),],
        ),
      ));
    }

    return MarkerLayer(
        markers: markers,
    );
  }

  bool notDisposed() {
    return _animationManager != null;
  }

  @override
  void dispose() {
    _mapController.dispose();
    _animationManager?.dispose();
    _animationManager = null;
    super.dispose();
  }
}

abstract class SelectedLocationHandler {
  /// onComplete(true) is called if this succeeds, otherwise onComplete(false).
  ///
  /// BuildContext is the [LocationWidget]'s context.
  Future<void> handleLocationSelection(
    {
      required BuildContext context,
      required LatLng location,
      required void Function() onStart,
      required void Function(bool) onComplete
    }
  );
}

class MapAnimationManager {
  // Location can be received after the widget is disposed
  MapController? _animatedMapController;
  late AnimationController _controller;
  late Animation<double> _latitudeAnimation;
  late Animation<double> _longitudeAnimation;
  late Animation<double> _zoomAnimation;
  bool animationAllowed = true;

  void init(MapController mapController, TickerProvider provider) {
    _animatedMapController = mapController;
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: provider);
    _controller.addListener(() {
      final newLocation = LatLng(_latitudeAnimation.value, _longitudeAnimation.value);
      _animatedMapController?.move(newLocation, _zoomAnimation.value);
    });
  }

  void dispose() {
    _controller.dispose();
    _animatedMapController = null;

    // TODO: dispose something else?
  }

  void preventAnimation() {
    animationAllowed = false;
  }

  void allowAnimation() {
    animationAllowed = true;
  }

  /// Start map animation with some limits, so that map does not
  /// move too fast or map is not zoomed too much or too little.
  void startLimitedMapAnimation(
    MapController mapController,
    LatLng targetLocation,
  ) {
    const locateMinZoom = 11.0;
    var targetZoom = locateMinZoom;
    if (mapController.camera.zoom > locateMinZoom) {
      targetZoom = mapController.camera.zoom;
    }
    const locateMaxZoom = 13.0;
    if (mapController.camera.zoom > locateMaxZoom) {
      targetZoom = locateMaxZoom;
    }

    // If target is far away, use min zoom to
    // make map move slower
    double? middleZoom; // Disabled currently
    bool longDistance = false;
    final locationIsOnVisibleMapArea = mapController.camera.visibleBounds.contains(targetLocation);
    const distance = DistanceHaversine();
    final distanceToTargetLocation = distance.as(LengthUnit.Kilometer, mapController.camera.center, targetLocation);
    if (!locationIsOnVisibleMapArea && distanceToTargetLocation > 100) {
      longDistance = true;
    }

    startMapAnimation(
      mapController.center,
      mapController.zoom,
      targetLocation,
      targetZoom,
      middleZoom,
      longDistance,
    );
  }

  void startMapAnimation(
    LatLng currentLocation,
    double currentZoom,
    LatLng targetLocation,
    double targetZoom,
    // Zoom value in the middle of the animation
    double? middleZoom,
    bool longDistance,
  ) {
    if (!animationAllowed || _animatedMapController == null) {
      return;
    }

    _controller.duration = const Duration(milliseconds: 1500);

    final latitudeTween = Tween<double>(
      begin: currentLocation.latitude,
      end: targetLocation.latitude,
    );

    final longitudeTween = Tween<double>(
      begin: currentLocation.longitude,
      end: targetLocation.longitude,
    );

    final Animatable<double> zoomTween;
    if (middleZoom != null) {
      zoomTween = TweenSequence([
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: currentZoom,
            end: middleZoom,
          ),
          weight: 1.0
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: middleZoom,
            end: targetZoom,
          ),
          weight: 1.0
        ),
      ]);
    } else {

      if (targetZoom > currentZoom && longDistance) {
        _controller.duration = const Duration(milliseconds: 1750);
        zoomTween = TweenSequence([
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: currentZoom,
              end: currentZoom,
            ),
            weight: 0.5
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: currentZoom,
              end: targetZoom,
            ),
            weight: 0.45
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: targetZoom,
              end: targetZoom,
            ),
            weight: 0.05
          )
        ]);
      } else {
        zoomTween = Tween<double>(
          begin: currentZoom,
          end: targetZoom,
        );
      }
    }

    final Curve curve;
    if (longDistance) {
      curve = Curves.easeInOutCirc;
    } else {
      curve = Curves.easeInOut;
    }

    final animation = CurvedAnimation(
      parent: _controller,
      curve: curve,
    );

    _latitudeAnimation = latitudeTween.animate(animation);
    _longitudeAnimation = longitudeTween.animate(animation);
    _zoomAnimation = zoomTween.animate(animation);

    _controller.reset();
    _controller.forward();
  }
}

Widget attributionWidget(BuildContext context) {
  return RichAttributionWidget(
    attributions: [
      TextSourceAttribution(
        context.strings.map_openstreetmap_data_attribution_link_text,
        onTap: () => launchUrl(Uri.parse("https://openstreetmap.org/copyright")),
      ),
    ],
    showFlutterMapAttribution: false,
    alignment: AttributionAlignment.bottomLeft,
  );
}

class CustomTileProvider extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    return CustomImageProvider(coordinates);
  }
}

class CustomImageProvider extends ImageProvider<(int, int, int)> {
  final TileCoordinates coordinates;

  CustomImageProvider(this.coordinates);

  File? file;

  @override
  ImageStreamCompleter loadImage((int, int, int) key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      () async {
        final file =
          await ImageCacheData.getInstance().getMapTile(coordinates.z, coordinates.x, coordinates.y);

        if (file == null) {
          return Future<ImageInfo>.error("Failed to load map tile");
        }

        final buffer = await ImmutableBuffer.fromFilePath(file.path);
        final codec = await decode(buffer);
        final frame = await codec.getNextFrame();

        return ImageInfo(image: frame.image);
      }(),
    );
  }

  @override
  Future<(int, int, int)> obtainKey(ImageConfiguration configuration) async {
    return (coordinates.z, coordinates.x, coordinates.y);
  }
}
