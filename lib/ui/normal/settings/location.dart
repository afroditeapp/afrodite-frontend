

import 'dart:ui';

import 'package:app/logic/account/client_features_config.dart';
import 'package:app/utils/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/logic/profile/location.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.profile_location_screen_title)),
      body: locationPage(context),
    );
  }

  Widget locationPage(BuildContext context) {
    return BlocBuilder<LocationBloc, Location?>(
      buildWhen: (previous, current) => previous == null && current != null,
      builder: (context, state) {
        final profileLocation = state;
        final bloc = context.read<LocationBloc>();
        if (profileLocation != null) {
          final profileLocationLatLng = LatLng(profileLocation.latitude, profileLocation.longitude);
          return LocationWidget(
            mode: MapMode.selectLocation,
            handler: LocationUploader(bloc.profile),
            markerInitialLocation: profileLocationLatLng,
            editingHelpText: context.strings.map_select_location_help_text,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

enum MapMode {
  selectInitialLocation,
  selectLocation,
}

class LocationUploader extends SelectedLocationHandler {
  bool locationUploadInProgress = false;
  ProfileRepository profile;

  LocationUploader(this.profile);

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
    final result = await profile.updateLocation(apiLocation);
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
    super.key,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

enum MapModeInternal {
  selectLocationNoModeButton,
  waitUpdateCompletionNoModeButton,
  selectLocation,
  viewLocation,
  viewLocationEditButtonDisabled,
}

/// Zoomed out country color in OpenStreetMap tiles
const MAP_BACKGROUND_COLOR = Color.fromARGB(255, 242, 239, 233);

class _LocationWidgetState extends State<LocationWidget> with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late final SelectedLocationHandler _locationSelectedHandler;
  MapAnimationManager? _animationManager = MapAnimationManager();
  LatLng? _profileLocationMarker;
  MapModeInternal _internalMode = MapModeInternal.selectLocationNoModeButton;

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
        _internalMode = MapModeInternal.selectLocationNoModeButton;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = context.read<ClientFeaturesConfigBloc>().state.config.map;

    final bounds = LatLngBounds(
      config.bounds.topLeft.toLatLng(),
      config.bounds.bottomRight.toLatLng(),
    );

    final LatLng initialLocation;
    final double initialZoom;

    final locationLatLng = _profileLocationMarker;
    if (locationLatLng != null && bounds.contains(locationLatLng)) {
      initialLocation = locationLatLng;
      initialZoom = config.zoom.locationSelected.toDouble();
    } else {
      initialLocation = config.initialLocation.toLatLng();
      initialZoom = config.zoom.locationNotSelected.toDouble();
    }

    final initialMap = FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: initialLocation,
        initialZoom: initialZoom,
        minZoom: config.zoom.min.toDouble(),
        maxZoom: config.zoom.max.toDouble(),
        cameraConstraint: CameraConstraint.contain(bounds: bounds),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onTap: (tapPosition, point) {
          handleOnTap(context, point);
        },
        onLongPress: (tapPosition, point) {
          handleOnTap(context, point);
        },
        backgroundColor: MAP_BACKGROUND_COLOR,
      ),
      children: [
        TileLayer(
          maxNativeZoom: config.zoom.maxTileDownloading,
          tileProvider: CustomTileProvider(),
        ),
        markerLayer(),
        attributionWidget(context),
        floatingActionButtons(),
        viewHelp(context),
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
                _internalMode = MapModeInternal.waitUpdateCompletionNoModeButton;
              });
            }
          },
          onComplete: (result) {
            if (mounted) {
              setState(() {
                _internalMode = MapModeInternal.selectLocationNoModeButton;
              });
            }
          },
        );
      case MapModeInternal.viewLocation || MapModeInternal.viewLocationEditButtonDisabled: {}
      case MapModeInternal.waitUpdateCompletionNoModeButton: {
        showSnackBar(context.strings.generic_previous_action_in_progress);
      }
    }
  }

  Widget? modeButton() {
    switch (_internalMode) {
      case MapModeInternal.selectLocationNoModeButton || MapModeInternal.waitUpdateCompletionNoModeButton:
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

  Widget viewHelp(BuildContext context) {
    final helpTextString = widget.editingHelpText;
    if (helpTextString == null) {
      return Container();
    }

    final helpText = Text(helpTextString);

    switch (_internalMode) {
      case MapModeInternal.selectLocationNoModeButton || MapModeInternal.selectLocation || MapModeInternal.waitUpdateCompletionNoModeButton:
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15.0,
                    color: Colors.black45,
                  )
                ],
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
    final markers = List<Marker>.empty(growable: true);

    const locationSize = 70.0;
    final profileLocation = _profileLocationMarker;
    if (profileLocation != null) {
      markers.add(Marker(
        width: locationSize,
        height: locationSize,
        point: profileLocation,
        alignment: Alignment.topCenter,
        child: Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
          size: locationSize,
          shadows: const [
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
    // LocationWidget disposes _animatedMapController
    _animatedMapController = null;
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
      mapController.camera.center,
      mapController.camera.zoom,
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

  @override
  ImageStreamCompleter loadImage((int, int, int) key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      () async {
        final pngBytes =
          await ImageCacheData.getInstance().getMapTile(
            coordinates.z,
            coordinates.x,
            coordinates.y,
            media: LoginRepository.getInstance().repositories.media,
          );

        if (pngBytes == null) {
          return Future<ImageInfo>.error("Failed to load map tile");
        }

        final buffer = await ImmutableBuffer.fromUint8List(pngBytes);
        final codec = await decode(buffer);
        final frame = await codec.getNextFrame();

        return ImageInfo(image: frame.image);
      }(),
    );
  }

  @override
  Future<(int, int, int)> obtainKey(ImageConfiguration configuration) =>
    SynchronousFuture((coordinates.z, coordinates.x, coordinates.y));

}
