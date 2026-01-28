import 'dart:async';

import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui_utils/profile_pictures.dart';
import 'package:database/database.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileProgressSaver extends StatefulWidget {
  final MyProfileBloc bloc;
  final AccountDatabaseManager db;
  const EditProfileProgressSaver({required this.bloc, required this.db, super.key});

  @override
  State<EditProfileProgressSaver> createState() => _EditProfileProgressSaverState();
}

class _EditProfileProgressSaverState extends State<EditProfileProgressSaver> {
  StreamSubscription<MyProfileData>? _subscription;

  @override
  void initState() {
    super.initState();

    widget.db.accountAction((db) => db.progress.setProfileEditingInProgressStatus(true));

    _subscription = widget.bloc.stream
        .debounceTime(const Duration(seconds: 1))
        .distinct()
        .asyncMap((state) async {
          final entry = EditProfileProgressEntry(
            age: state.valueAge(),
            name: state.valueName(),
            profileText: state.valueProfileText(),
            profileAttributes: state.valueAttributeIdAndStateMap().values.toList(),
            unlimitedLikes: state.valueUnlimitedLikes(),
            profileImages: state
                .valuePictures()
                .map((p) {
                  if (p is ImageSelected) {
                    return ProfilePictureEntry(
                      contentId: p.id.contentId.cid,
                      slot: p.slot,
                      faceDetected: p.id.faceDetected,
                      accepted: p.id.accepted,
                      cropSize: p.cropArea.gridCropSize,
                      cropX: p.cropArea.gridCropX,
                      cropY: p.cropArea.gridCropY,
                    );
                  }
                  return null;
                })
                .nonNulls
                .toList(),
          );
          await widget.db.accountAction((db) => db.progress.updateEditProfileProgress(entry));
          return state;
        })
        .listen((_) {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.db.accountAction((db) => db.progress.setProfileEditingInProgressStatus(false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
