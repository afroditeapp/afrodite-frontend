

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).pageLocationTitle)),
      body: locationPage(context),
    );
  }

  Widget locationPage(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: const LatLng(60.25, 24.940166),
        zoom: 8,
        minZoom: 4,
        maxZoom: 13.49,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              "OpenStreetMap contributors",
              onTap: () => launchUrl(Uri.parse("https://openstreetmap.org/copyright")),
            ),
          ],
          showFlutterMapAttribution: false,
          alignment: AttributionAlignment.bottomLeft,
        ),
      ],
      children: [
        TileLayer(
          tileProvider: CustomTileProvider(),
        ),
      ],
    );
  }
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
