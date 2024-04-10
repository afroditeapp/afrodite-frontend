import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/utils.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'edit_my_profile.freezed.dart';

@freezed
class EditMyProfileData with _$EditMyProfileData {
  factory EditMyProfileData({
    int? age,
    String? initial,
  }) = _EditMyProfileData;
}
