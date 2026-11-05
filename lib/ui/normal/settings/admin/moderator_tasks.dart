import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/moderate_profile_string.dart';
import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
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

class ModeratorTasksPage extends MyScreenPage<()> {
  ModeratorTasksPage(RepositoryInstances r, {bool showAll = false})
    : super(builder: (_) => ModeratorTasksScreen(r, showAll: showAll));
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

  RequiredData copyWith({
    bool? contentBotInitial,
    bool? contentHumanInitial,
    bool? contentBot,
    bool? contentHuman,
    bool? profileNamesBot,
    bool? profileNamesHuman,
    bool? profileTextsBot,
    bool? profileTextsHuman,
    bool? reports,
  }) {
    return RequiredData(
      contentBotInitial: contentBotInitial ?? this.contentBotInitial,
      contentHumanInitial: contentHumanInitial ?? this.contentHumanInitial,
      contentBot: contentBot ?? this.contentBot,
      contentHuman: contentHuman ?? this.contentHuman,
      profileNamesBot: profileNamesBot ?? this.profileNamesBot,
      profileNamesHuman: profileNamesHuman ?? this.profileNamesHuman,
      profileTextsBot: profileTextsBot ?? this.profileTextsBot,
      profileTextsHuman: profileTextsHuman ?? this.profileTextsHuman,
      reports: reports ?? this.reports,
    );
  }
}

class ModeratorTasksScreen extends StatefulWidget {
  final ApiManager api;
  final ServerConnectionManager connectionManager;
  final AccountRepository account;

  final bool showAll;
  ModeratorTasksScreen(RepositoryInstances r, {required this.showAll, super.key})
    : api = r.api,
      connectionManager = r.connectionManager,
      account = r.account;

  @override
  State<ModeratorTasksScreen> createState() => _ModeratorTasksScreenState();
}

class _ModeratorTasksScreenState extends State<ModeratorTasksScreen> {
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

    final hasMediaContent = permissions.adminModerateMediaContent;
    final contentBotInitial = hasMediaContent
        ? await _hasWaitingMediaContent(
            MediaContentModerationType.initial,
            MediaContentModerationQueueType.waitingAdminBot,
          )
        : false;
    final contentHumanInitial = hasMediaContent
        ? await _hasWaitingMediaContent(
            MediaContentModerationType.initial,
            MediaContentModerationQueueType.waitingAdmin,
          )
        : false;
    final contentBot = hasMediaContent
        ? await _hasWaitingMediaContent(
            MediaContentModerationType.normal,
            MediaContentModerationQueueType.waitingAdminBot,
          )
        : false;
    final contentHuman = hasMediaContent
        ? await _hasWaitingMediaContent(
            MediaContentModerationType.normal,
            MediaContentModerationQueueType.waitingAdmin,
          )
        : false;

    final hasProfileNames = permissions.adminModerateProfileNames;
    final profileNamesBot = hasProfileNames
        ? await _hasWaitingProfileString(
            ProfileStringModerationContentType.profileName,
            ProfileStringModerationQueueType.waitingAdminBot,
          )
        : false;
    final profileNamesHuman = hasProfileNames
        ? await _hasWaitingProfileString(
            ProfileStringModerationContentType.profileName,
            ProfileStringModerationQueueType.waitingAdmin,
          )
        : false;

    final hasProfileTexts = permissions.adminModerateProfileTexts;
    final profileTextsBot = hasProfileTexts
        ? await _hasWaitingProfileString(
            ProfileStringModerationContentType.profileText,
            ProfileStringModerationQueueType.waitingAdminBot,
          )
        : false;
    final profileTextsHuman = hasProfileTexts
        ? await _hasWaitingProfileString(
            ProfileStringModerationContentType.profileText,
            ProfileStringModerationQueueType.waitingAdmin,
          )
        : false;

    final reports = hasProfileNames ? await _hasWaitingReports() : false;

    if (contentBotInitial == null ||
        contentHumanInitial == null ||
        contentBot == null ||
        contentHuman == null ||
        profileNamesBot == null ||
        profileNamesHuman == null ||
        profileTextsBot == null ||
        profileTextsHuman == null ||
        reports == null) {
      if (!context.mounted) {
        return;
      }
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      if (!context.mounted) {
        return;
      }
      setState(() {
        isLoading = false;
        data = RequiredData(
          contentBotInitial: contentBotInitial,
          contentHumanInitial: contentHumanInitial,
          contentBot: contentBot,
          contentHuman: contentHuman,
          profileNamesBot: profileNamesBot,
          profileNamesHuman: profileNamesHuman,
          profileTextsBot: profileTextsBot,
          profileTextsHuman: profileTextsHuman,
          reports: reports,
        );
      });
    }
  }

  Future<bool?> _hasWaitingMediaContent(
    MediaContentModerationType moderationType,
    MediaContentModerationQueueType queueType,
  ) async {
    final queue = await widget.api
        .mediaAdmin(
          (api) => api.getMediaContentModerationQueuePage(
            MediaContentType.jpegImage,
            moderationType,
            queueType,
          ),
        )
        .ok();
    return queue?.values.isNotEmpty;
  }

  Future<bool?> _hasWaitingProfileString(
    ProfileStringModerationContentType contentType,
    ProfileStringModerationQueueType queueType,
  ) async {
    final queue = await widget.api
        .profileAdmin((api) => api.getProfileStringModerationQueuePage(contentType, queueType))
        .ok();
    return queue?.values.isNotEmpty;
  }

  Future<bool?> _hasWaitingReports() async {
    final reports = await widget.api
        .commonAdmin(
          (api) =>
              api.postGetReportQueuePage(GetReportQueuePage(queueType: ReportQueueType.waiting)),
        )
        .ok();
    return reports?.values.isNotEmpty;
  }

  Future<void> _reloadMediaTask(
    MediaContentModerationType moderationType,
    MediaContentModerationQueueType queueType,
    RequiredData Function(RequiredData data, bool hasItems) apply,
  ) async {
    final hasItems = await _hasWaitingMediaContent(moderationType, queueType);
    if (!mounted || data == null || hasItems == null) return;
    setState(() {
      data = apply(data!, hasItems);
    });
  }

  Future<void> _reloadProfileStringTask(
    ProfileStringModerationContentType contentType,
    ProfileStringModerationQueueType queueType,
    RequiredData Function(RequiredData data, bool hasItems) apply,
  ) async {
    final hasItems = await _hasWaitingProfileString(contentType, queueType);
    if (!mounted || data == null || hasItems == null) return;
    setState(() {
      data = apply(data!, hasItems);
    });
  }

  Future<void> _reloadReportsTask() async {
    final hasItems = await _hasWaitingReports();
    if (!mounted || data == null || hasItems == null) return;
    setState(() {
      data = data!.copyWith(reports: hasItems);
    });
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
    final widgets = <Widget>[];

    void addCategory(String title, List<Setting> settings) {
      if (settings.isEmpty) return;
      widgets.add(settingsCategoryTitle(context, title));
      widgets.addAll(settings.map((setting) => setting.toListTile()));
    }

    addCategory("Bot", botTasks(context, data));
    addCategory("Human", humanTasks(context, data));

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets),
    );
  }

  List<Setting> botTasks(BuildContext context, RequiredData data) {
    return [
      if (data.contentBotInitial) moderateImagesInitialBotSetting(context),
      if (data.contentBot) moderateImagesNormalBotSetting(context),
      if (data.profileNamesBot) moderateProfileNamesBotSetting(context),
      if (data.profileTextsBot) moderateProfileTextsBotSetting(context),
    ];
  }

  List<Setting> humanTasks(BuildContext context, RequiredData data) {
    return [
      if (data.contentHumanInitial) moderateImagesInitialHumanSetting(context),
      if (data.contentHuman) moderateImagesNormalHumanSetting(context),
      if (data.profileNamesHuman) moderateProfileNamesHumanSetting(context),
      if (data.profileTextsHuman) moderateProfileTextsHumanSetting(context),
      if (data.reports) processReportsSetting(context),
    ];
  }

  Future<void> _openAndReload(
    BuildContext context,
    MyScreenPageLimited<()> page,
    Future<void> Function() reload,
  ) async {
    await MyNavigator.pushLimited(context, page);
    if (!mounted) return;
    await reload();
  }

  Setting moderateImagesInitialBotSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (initial, bot)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.initial,
          queueType: MediaContentModerationQueueType.waitingAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.initial,
          MediaContentModerationQueueType.waitingAdminBot,
          (data, hasItems) => data.copyWith(contentBotInitial: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesInitialHumanSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (initial, human)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.initial,
          queueType: MediaContentModerationQueueType.waitingAdmin,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.initial,
          MediaContentModerationQueueType.waitingAdmin,
          (data, hasItems) => data.copyWith(contentHumanInitial: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesNormalBotSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (normal, bot)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.normal,
          queueType: MediaContentModerationQueueType.waitingAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.normal,
          MediaContentModerationQueueType.waitingAdminBot,
          (data, hasItems) => data.copyWith(contentBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesNormalHumanSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (normal, human)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.normal,
          queueType: MediaContentModerationQueueType.waitingAdmin,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.normal,
          MediaContentModerationQueueType.waitingAdmin,
          (data, hasItems) => data.copyWith(contentHuman: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileNamesBotSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile names (bot)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileName,
          queueType: ProfileStringModerationQueueType.waitingAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileName,
          ProfileStringModerationQueueType.waitingAdminBot,
          (data, hasItems) => data.copyWith(profileNamesBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileNamesHumanSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile names (human)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileName,
          queueType: ProfileStringModerationQueueType.waitingAdmin,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileName,
          ProfileStringModerationQueueType.waitingAdmin,
          (data, hasItems) => data.copyWith(profileNamesHuman: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileTextsBotSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile texts (bot)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileText,
          queueType: ProfileStringModerationQueueType.waitingAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileText,
          ProfileStringModerationQueueType.waitingAdminBot,
          (data, hasItems) => data.copyWith(profileTextsBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileTextsHumanSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile texts (human)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileText,
          queueType: ProfileStringModerationQueueType.waitingAdmin,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileText,
          ProfileStringModerationQueueType.waitingAdmin,
          (data, hasItems) => data.copyWith(profileTextsHuman: hasItems),
        ),
      ),
    );
  }

  Setting processReportsSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.report,
      "Process reports",
      () => _openAndReload(
        context,
        ProcessReportsPage(r, queueType: ReportQueueType.waiting),
        _reloadReportsTask,
      ),
    );
  }
}
