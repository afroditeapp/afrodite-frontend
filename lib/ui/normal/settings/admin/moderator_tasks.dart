import 'package:app/data/login_repository.dart';
import 'package:app/ui/normal/settings/admin/moderate_profile_string.dart';
import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/moderate_images.dart';

NewPageDetails newModeratorTasksScreen() {
  return NewPageDetails(const MaterialPage<void>(child: ModeratorTasksScreen()));
}

class RequiredData {
  final bool contentBotInitial;
  final bool contentHumanInitial;
  final bool contentBot;
  final bool contentHuman;
  final bool profileNamesBot;
  final bool profileNamesHuman;
  final bool profileTextsBot;
  final bool profileTextsHuman;
  final bool reports;

  RequiredData({
    required this.contentBotInitial,
    required this.contentHumanInitial,
    required this.contentBot,
    required this.contentHuman,
    required this.profileNamesBot,
    required this.profileNamesHuman,
    required this.profileTextsBot,
    required this.profileTextsHuman,
    required this.reports,
  });
}

class ModeratorTasksScreen extends StatefulWidget {
  final bool showAll;
  const ModeratorTasksScreen({this.showAll = false, super.key});

  @override
  State<ModeratorTasksScreen> createState() => _ModeratorTasksScreenState();
}

class _ModeratorTasksScreenState extends State<ModeratorTasksScreen> {
  final connectionManager = LoginRepository.getInstance().repositories.connectionManager;
  final account = LoginRepository.getInstance().repositories.account;
  final api = LoginRepository.getInstance().repositories.api;

  Permissions permissions = Permissions();
  RequiredData? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    await connectionManager.waitUntilCurrentSessionConnects();
    permissions = await account.permissions.firstOrNull ?? Permissions();

    if (widget.showAll) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        isLoading = false;
        data = RequiredData(
          contentBotInitial: permissions.adminModerateMediaContent,
          contentHumanInitial: permissions.adminModerateMediaContent,
          contentBot: permissions.adminModerateMediaContent,
          contentHuman: permissions.adminModerateMediaContent,
          profileNamesBot: permissions.adminModerateProfileNames,
          profileNamesHuman: permissions.adminModerateProfileNames,
          profileTextsBot: permissions.adminModerateProfileTexts,
          profileTextsHuman: permissions.adminModerateProfileTexts,
          reports: permissions.adminProcessReports,
        );
      });
      return;
    }

    final GetMediaContentPendingModerationList? contentBotInitial;
    final GetMediaContentPendingModerationList? contentHumanInitial;
    final GetMediaContentPendingModerationList? contentBot;
    final GetMediaContentPendingModerationList? contentHuman;
    if (permissions.adminModerateMediaContent) {
      contentBotInitial = await api
          .mediaAdmin(
            (api) => api.getMediaContentPendingModerationList(
              MediaContentType.jpegImage,
              ModerationQueueType.initialMediaModeration,
              true,
            ),
          )
          .ok();
      contentHumanInitial = await api
          .mediaAdmin(
            (api) => api.getMediaContentPendingModerationList(
              MediaContentType.jpegImage,
              ModerationQueueType.initialMediaModeration,
              false,
            ),
          )
          .ok();
      contentBot = await api
          .mediaAdmin(
            (api) => api.getMediaContentPendingModerationList(
              MediaContentType.jpegImage,
              ModerationQueueType.mediaModeration,
              true,
            ),
          )
          .ok();
      contentHuman = await api
          .mediaAdmin(
            (api) => api.getMediaContentPendingModerationList(
              MediaContentType.jpegImage,
              ModerationQueueType.mediaModeration,
              false,
            ),
          )
          .ok();
    } else {
      final empty = GetMediaContentPendingModerationList();
      contentBotInitial = empty;
      contentHumanInitial = empty;
      contentBot = empty;
      contentHuman = empty;
    }

    final GetProfileStringPendingModerationList? profileNamesBot;
    final GetProfileStringPendingModerationList? profileNamesHuman;
    if (permissions.adminModerateProfileNames) {
      profileNamesBot = await api
          .profileAdmin(
            (api) => api.getProfileStringPendingModerationList(
              ProfileStringModerationContentType.profileName,
              true,
            ),
          )
          .ok();
      profileNamesHuman = await api
          .profileAdmin(
            (api) => api.getProfileStringPendingModerationList(
              ProfileStringModerationContentType.profileName,
              false,
            ),
          )
          .ok();
    } else {
      profileNamesBot = GetProfileStringPendingModerationList();
      profileNamesHuman = GetProfileStringPendingModerationList();
    }

    final GetProfileStringPendingModerationList? profileTextsBot;
    final GetProfileStringPendingModerationList? profileTextsHuman;
    if (permissions.adminModerateProfileTexts) {
      profileTextsBot = await api
          .profileAdmin(
            (api) => api.getProfileStringPendingModerationList(
              ProfileStringModerationContentType.profileText,
              true,
            ),
          )
          .ok();
      profileTextsHuman = await api
          .profileAdmin(
            (api) => api.getProfileStringPendingModerationList(
              ProfileStringModerationContentType.profileText,
              false,
            ),
          )
          .ok();
    } else {
      profileTextsBot = GetProfileStringPendingModerationList();
      profileTextsHuman = GetProfileStringPendingModerationList();
    }

    final GetReportList? reports;
    if (permissions.adminModerateProfileNames) {
      reports = await api.commonAdmin((api) => api.getWaitingReportPage()).ok();
    } else {
      reports = GetReportList();
    }

    if (!context.mounted) {
      return;
    }

    if (contentBotInitial == null ||
        contentHumanInitial == null ||
        contentBot == null ||
        contentHuman == null ||
        profileNamesBot == null ||
        profileNamesHuman == null ||
        profileTextsBot == null ||
        profileTextsHuman == null ||
        reports == null) {
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
          contentHumanInitial: contentHumanInitial?.values.isNotEmpty ?? false,
          contentBot: contentBot?.values.isNotEmpty ?? false,
          contentHuman: contentHuman?.values.isNotEmpty ?? false,
          profileNamesBot: profileNamesBot?.values.isNotEmpty ?? false,
          profileNamesHuman: profileNamesHuman?.values.isNotEmpty ?? false,
          profileTextsBot: profileTextsBot?.values.isNotEmpty ?? false,
          profileTextsHuman: profileTextsHuman?.values.isNotEmpty ?? false,
          reports: reports?.values.isNotEmpty ?? false,
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
      appBar: AppBar(title: const Text("Moderator tasks")),
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
    List<Setting> settings = [
      if (data.contentBotInitial)
        Setting.createSetting(
          Icons.image,
          "Moderate images (initial moderation, bot and human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateImagesScreen(
                queueType: ModerationQueueType.initialMediaModeration,
                showContentWhichBotsCanModerate: true,
              ),
            ),
          ),
        ),
      if (data.contentHumanInitial)
        Setting.createSetting(
          Icons.image,
          "Moderate images (initial moderation, human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateImagesScreen(
                queueType: ModerationQueueType.initialMediaModeration,
                showContentWhichBotsCanModerate: false,
              ),
            ),
          ),
        ),
      if (data.contentBot)
        Setting.createSetting(
          Icons.image,
          "Moderate images (normal, bot and human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateImagesScreen(
                queueType: ModerationQueueType.mediaModeration,
                showContentWhichBotsCanModerate: true,
              ),
            ),
          ),
        ),
      if (data.contentHuman)
        Setting.createSetting(
          Icons.image,
          "Moderate images (normal, human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateImagesScreen(
                queueType: ModerationQueueType.mediaModeration,
                showContentWhichBotsCanModerate: false,
              ),
            ),
          ),
        ),
      if (data.profileNamesBot)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile names (bot and human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateProfileStringsScreen(
                contentType: ProfileStringModerationContentType.profileName,
                showTextsWhichBotsCanModerate: true,
              ),
            ),
          ),
        ),
      if (data.profileNamesHuman)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile names (human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateProfileStringsScreen(
                contentType: ProfileStringModerationContentType.profileName,
                showTextsWhichBotsCanModerate: false,
              ),
            ),
          ),
        ),
      if (data.profileTextsBot)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile texts (bot and human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateProfileStringsScreen(
                contentType: ProfileStringModerationContentType.profileText,
                showTextsWhichBotsCanModerate: true,
              ),
            ),
          ),
        ),
      if (data.profileTextsHuman)
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile texts (human)",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateProfileStringsScreen(
                contentType: ProfileStringModerationContentType.profileText,
                showTextsWhichBotsCanModerate: false,
              ),
            ),
          ),
        ),
      if (data.reports)
        Setting.createSetting(
          Icons.report,
          "Process reports",
          () => MyNavigator.push(context, MaterialPage<void>(child: ProcessReportsScreen())),
        ),
    ];
    return settings.map((v) => v.toListTile());
  }
}
