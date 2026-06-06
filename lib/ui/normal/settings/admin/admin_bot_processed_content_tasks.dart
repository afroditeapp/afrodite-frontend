import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/moderate_profile_string.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/moderate_images.dart';

class AdminBotProcessedContentTasksPage extends MyScreenPage<()> {
  AdminBotProcessedContentTasksPage(RepositoryInstances r, {bool showAll = false})
    : super(builder: (_) => AdminBotProcessedContentTasksScreen(r, showAll: showAll));
}

class RequiredData {
  final bool contentBotInitial;
  final bool contentBot;
  final bool profileNamesBot;
  final bool profileTextsBot;

  RequiredData({
    required this.contentBotInitial,
    required this.contentBot,
    required this.profileNamesBot,
    required this.profileTextsBot,
  });
}

class AdminBotProcessedContentTasksScreen extends StatefulWidget {
  final ApiManager api;
  final ServerConnectionManager connectionManager;
  final AccountRepository account;

  final bool showAll;
  AdminBotProcessedContentTasksScreen(RepositoryInstances r, {required this.showAll, super.key})
    : api = r.api,
      connectionManager = r.connectionManager,
      account = r.account;

  @override
  State<AdminBotProcessedContentTasksScreen> createState() =>
      _AdminBotProcessedContentTasksScreenState();
}

class _AdminBotProcessedContentTasksScreenState extends State<AdminBotProcessedContentTasksScreen> {
  Permissions permissions = Permissions();
  RequiredData? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    await widget.connectionManager.tryWaitUntilConnected();
    permissions = await widget.account.permissions.firstOrNull ?? Permissions();

    if (widget.showAll) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        isLoading = false;
        data = RequiredData(
          contentBotInitial: permissions.adminModerateMediaContent,
          contentBot: permissions.adminModerateMediaContent,
          profileNamesBot: permissions.adminModerateProfileNames,
          profileTextsBot: permissions.adminModerateProfileTexts,
        );
      });
      return;
    }

    final MediaContentModerationQueuePage? contentBotInitial;
    final MediaContentModerationQueuePage? contentBot;
    if (permissions.adminModerateMediaContent) {
      contentBotInitial = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.initial,
              MediaContentModerationQueueType.processedByAdminBot,
            ),
          )
          .ok();
      contentBot = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.normal,
              MediaContentModerationQueueType.processedByAdminBot,
            ),
          )
          .ok();
    } else {
      final empty = MediaContentModerationQueuePage();
      contentBotInitial = empty;
      contentBot = empty;
    }

    final ProfileStringModerationQueuePage? profileNamesBot;
    if (permissions.adminModerateProfileNames) {
      profileNamesBot = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileName,
              ProfileStringModerationQueueType.processedByAdminBot,
            ),
          )
          .ok();
    } else {
      profileNamesBot = ProfileStringModerationQueuePage();
    }

    final ProfileStringModerationQueuePage? profileTextsBot;
    if (permissions.adminModerateProfileTexts) {
      profileTextsBot = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileText,
              ProfileStringModerationQueueType.processedByAdminBot,
            ),
          )
          .ok();
    } else {
      profileTextsBot = ProfileStringModerationQueuePage();
    }

    if (!context.mounted) {
      return;
    }

    if (contentBotInitial == null ||
        contentBot == null ||
        profileNamesBot == null ||
        profileTextsBot == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = RequiredData(
          contentBotInitial: contentBotInitial?.values.isNotEmpty ?? false,
          contentBot: contentBot?.values.isNotEmpty ?? false,
          profileNamesBot: profileNamesBot?.values.isNotEmpty ?? false,
          profileTextsBot: profileTextsBot?.values.isNotEmpty ?? false,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin bot processed content tasks")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final currentData = data;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || currentData == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return taskListWidget(context, currentData);
    }
  }

  Widget taskListWidget(BuildContext context, RequiredData data) {
    return SingleChildScrollView(child: Column(children: [...tasks(context, data)]));
  }

  Iterable<Widget> tasks(BuildContext context, RequiredData data) {
    final r = context.read<RepositoryInstances>();
    List<Setting> settings = [
      if (data.contentBotInitial)
        Setting.createSetting(
          Icons.image,
          "Moderate images (initial, bot)",
          () => MyNavigator.pushLimited(
            context,
            ModerateImagesPage(
              r,
              moderationType: MediaContentModerationType.initial,
              queueType: MediaContentModerationQueueType.processedByAdminBot,
            ),
          ),
        ),
      if (data.contentBot)
        Setting.createSetting(
          Icons.image,
          "Moderate images (normal, bot)",
          () => MyNavigator.pushLimited(
            context,
            ModerateImagesPage(
              r,
              moderationType: MediaContentModerationType.normal,
              queueType: MediaContentModerationQueueType.processedByAdminBot,
            ),
          ),
        ),
      if (data.profileNamesBot)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile names (bot)",
          () => MyNavigator.pushLimited(
            context,
            ModerateProfileStringsPage(
              r,
              contentType: ProfileStringModerationContentType.profileName,
              queueType: ProfileStringModerationQueueType.processedByAdminBot,
            ),
          ),
        ),
      if (data.profileTextsBot)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile texts (bot)",
          () => MyNavigator.pushLimited(
            context,
            ModerateProfileStringsPage(
              r,
              contentType: ProfileStringModerationContentType.profileText,
              queueType: ProfileStringModerationQueueType.processedByAdminBot,
            ),
          ),
        ),
    ];
    return settings.map((v) => v.toListTile());
  }
}
