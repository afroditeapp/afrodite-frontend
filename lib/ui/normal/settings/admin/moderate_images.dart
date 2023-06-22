

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


// Plan: Infinite list of rows of two images, first is security selfie, the
// other is to be moderated image. First image is empty if moderating security
// selfie.
//
// Long pressing the row opens option to discard the request. Maeby there should
// be space in the right side for status color.
//
// If trying to display previous rows, maeby just display empty rows? After it
// is not possible to load more entries then empty rows untill all moderated.
// Change entry to contain message all moderated.
//
// Taping image should open it to another view.


class ModerateImagesPage extends StatefulWidget {
  const ModerateImagesPage({Key? key}) : super(key: key);

  @override
  _ModerateImagesPageState createState() => _ModerateImagesPageState();
}

class _ModerateImagesPageState extends State<ModerateImagesPage> {
  bool reset = true;

  @override
  void initState() {
    super.initState();
    reset = true;
  }

  @override
  Widget build(BuildContext context) {
    if (reset) {
      context.read<ImageModerationBloc>().add(ResetImageModerationData());
      context.read<ImageModerationBloc>().add(GetMoreData());
      reset = false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Moderate images")),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return BlocBuilder<ImageModerationBloc, ImageModerationData>(
      builder: (context, state) {
        switch (state.state) {
          case ImageModerationStatus.loading:
            return SizedBox(width: 10, height: 10, child: CircularProgressIndicator());
          case ImageModerationStatus.moderating || ImageModerationStatus.moderatingAndNoMoreData:
            return ListView.builder(
              itemCount: null,
              itemBuilder: (context, index) {
                return buildEntry(context, state, index);
              },
            );
        }
      },
    );
  }

  Widget buildEntry(BuildContext contex, ImageModerationData state, int index) {
    final (entry, requestEntry) = state.data[index] ?? (null, null);

    if (entry != null && requestEntry != null) {
      void Function()? acceptModeration;
      void Function()? denyModeration;
      if (entry.status == null) {
        acceptModeration = () {
          context.read<ImageModerationBloc>().add(ModerateEntry(index, true));
        };
        denyModeration = () {
          context.read<ImageModerationBloc>().add(ModerateEntry(index, false));
        };
      }

      return Column(
        children: [
          Text("${entry.securitySelfie.toString()}, ${entry.target.toString()}"),
          Text(requestEntry.m.toString()),
          FutureBuilder(
            future: ImageCacheData.getInstance().getImage(requestEntry.m.requestCreatorId, entry.target),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data != null) {
                return Image.memory(data, height: 300,);
              } else if (snapshot.error != null) {
                return Text("Loading error");
              } else {
                return SizedBox(width: 50, height: 50, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ));
              }
          },),
          ElevatedButton(
            child: Text("Accept"),
            onPressed: acceptModeration,
          ),
          ElevatedButton(
            child: Text("Deny"),
            onPressed: denyModeration,
          ),
        ],
      );
    } else {
      switch (state.state) {
        case ImageModerationStatus.loading || ImageModerationStatus.moderating:
          return SizedBox(width: 50, height: 50, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ));
        case ImageModerationStatus.moderatingAndNoMoreData:
          return Text("All loaded");
      }
    }
  }
}
