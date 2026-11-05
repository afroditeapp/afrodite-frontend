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
import 'package:app/ui/normal/settings/admin/report/process_reports.dart';

class AdminBotProcessedContentTasksPage extends MyScreenPage<()> {
  AdminBotProcessedContentTasksPage(RepositoryInstances r, {bool showAll = false})
    : super(builder: (_) => AdminBotProcessedContentTasksScreen(r, showAll: showAll));
}

class RequiredData {
  final bool contentBotInitial;
  final bool contentBotInitialRejected;
  final bool contentBot;
  final bool contentBotRejected;
  final bool profileNamesBot;
  final bool profileNamesBotRejected;
  final bool profileTextsBot;
  final bool profileTextsBotRejected;
  final bool reportsBot;
  final bool reportsBotRejected;

  RequiredData({
    required this.contentBotInitial,
    required this.contentBotInitialRejected,
    required this.contentBot,
    required this.contentBotRejected,
    required this.profileNamesBot,
    required this.profileNamesBotRejected,
    required this.profileTextsBot,
    required this.profileTextsBotRejected,
    required this.reportsBot,
    required this.reportsBotRejected,
  });

  RequiredData copyWith({
    bool? contentBotInitial,
    bool? contentBotInitialRejected,
    bool? contentBot,
    bool? contentBotRejected,
    bool? profileNamesBot,
    bool? profileNamesBotRejected,
    bool? profileTextsBot,
    bool? profileTextsBotRejected,
    bool? reportsBot,
    bool? reportsBotRejected,
  }) {
    return RequiredData(
      contentBotInitial: contentBotInitial ?? this.contentBotInitial,
      contentBotInitialRejected: contentBotInitialRejected ?? this.contentBotInitialRejected,
      contentBot: contentBot ?? this.contentBot,
      contentBotRejected: contentBotRejected ?? this.contentBotRejected,
      profileNamesBot: profileNamesBot ?? this.profileNamesBot,
      profileNamesBotRejected: profileNamesBotRejected ?? this.profileNamesBotRejected,
      profileTextsBot: profileTextsBot ?? this.profileTextsBot,
      profileTextsBotRejected: profileTextsBotRejected ?? this.profileTextsBotRejected,
      reportsBot: reportsBot ?? this.reportsBot,
      reportsBotRejected: reportsBotRejected ?? this.reportsBotRejected,
    );
  }
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
          contentBotInitialRejected: permissions.adminModerateMediaContent,
          contentBot: permissions.adminModerateMediaContent,
          contentBotRejected: permissions.adminModerateMediaContent,
          profileNamesBot: permissions.adminModerateProfileNames,
          profileNamesBotRejected: permissions.adminModerateProfileNames,
          profileTextsBot: permissions.adminModerateProfileTexts,
          profileTextsBotRejected: permissions.adminModerateProfileTexts,
          reportsBot: permissions.adminProcessReports,
          reportsBotRejected: permissions.adminProcessReports,
        );
      });
      return;
    }

    final hasMediaContent = permissions.adminModerateMediaContent;
    final contentBotInitial = hasMediaContent
        ? await _hasMediaTask(
            MediaContentModerationType.initial,
            MediaContentModerationQueueType.acceptedByAdminBot,
          )
        : false;
    final contentBotInitialRejected = hasMediaContent
        ? await _hasMediaTask(
            MediaContentModerationType.initial,
            MediaContentModerationQueueType.rejectedByAdminBot,
          )
        : false;
    final contentBot = hasMediaContent
        ? await _hasMediaTask(
            MediaContentModerationType.normal,
            MediaContentModerationQueueType.acceptedByAdminBot,
          )
        : false;
    final contentBotRejected = hasMediaContent
        ? await _hasMediaTask(
            MediaContentModerationType.normal,
            MediaContentModerationQueueType.rejectedByAdminBot,
          )
        : false;

    final hasProfileNames = permissions.adminModerateProfileNames;
    final profileNamesBot = hasProfileNames
        ? await _hasProfileStringTask(
            ProfileStringModerationContentType.profileName,
            ProfileStringModerationQueueType.acceptedByAdminBot,
          )
        : false;
    final profileNamesBotRejected = hasProfileNames
        ? await _hasProfileStringTask(
            ProfileStringModerationContentType.profileName,
            ProfileStringModerationQueueType.rejectedByAdminBot,
          )
        : false;

    final hasProfileTexts = permissions.adminModerateProfileTexts;
    final profileTextsBot = hasProfileTexts
        ? await _hasProfileStringTask(
            ProfileStringModerationContentType.profileText,
            ProfileStringModerationQueueType.acceptedByAdminBot,
          )
        : false;
    final profileTextsBotRejected = hasProfileTexts
        ? await _hasProfileStringTask(
            ProfileStringModerationContentType.profileText,
            ProfileStringModerationQueueType.rejectedByAdminBot,
          )
        : false;

    final hasReports = permissions.adminProcessReports;
    final reportsBot = hasReports
        ? await _hasReportsTask(ReportQueueType.acceptedByAdminBot)
        : false;
    final reportsBotRejected = hasReports
        ? await _hasReportsTask(ReportQueueType.rejectedByAdminBot)
        : false;

    if (!context.mounted) {
      return;
    }

    if (contentBotInitial == null ||
        contentBotInitialRejected == null ||
        contentBot == null ||
        contentBotRejected == null ||
        profileNamesBot == null ||
        profileNamesBotRejected == null ||
        profileTextsBot == null ||
        profileTextsBotRejected == null ||
        reportsBot == null ||
        reportsBotRejected == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = RequiredData(
          contentBotInitial: contentBotInitial,
          contentBotInitialRejected: contentBotInitialRejected,
          contentBot: contentBot,
          contentBotRejected: contentBotRejected,
          profileNamesBot: profileNamesBot,
          profileNamesBotRejected: profileNamesBotRejected,
          profileTextsBot: profileTextsBot,
          profileTextsBotRejected: profileTextsBotRejected,
          reportsBot: reportsBot,
          reportsBotRejected: reportsBotRejected,
        );
      });
    }
  }

  Future<bool?> _hasMediaTask(
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

  Future<bool?> _hasProfileStringTask(
    ProfileStringModerationContentType contentType,
    ProfileStringModerationQueueType queueType,
  ) async {
    final queue = await widget.api
        .profileAdmin((api) => api.getProfileStringModerationQueuePage(contentType, queueType))
        .ok();
    return queue?.values.isNotEmpty;
  }

  Future<bool?> _hasReportsTask(ReportQueueType queueType) async {
    final reports = await widget.api
        .commonAdmin((api) => api.postGetReportQueuePage(GetReportQueuePage(queueType: queueType)))
        .ok();
    return reports?.values.isNotEmpty;
  }

  Future<void> _reloadMediaTask(
    MediaContentModerationType moderationType,
    MediaContentModerationQueueType queueType,
    RequiredData Function(RequiredData data, bool hasItems) apply,
  ) async {
    final hasItems = await _hasMediaTask(moderationType, queueType);
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
    final hasItems = await _hasProfileStringTask(contentType, queueType);
    if (!mounted || data == null || hasItems == null) return;
    setState(() {
      data = apply(data!, hasItems);
    });
  }

  Future<void> _reloadReportsTask(
    ReportQueueType queueType,
    RequiredData Function(RequiredData data, bool hasItems) apply,
  ) async {
    final hasItems = await _hasReportsTask(queueType);
    if (!mounted || data == null || hasItems == null) return;
    setState(() {
      data = apply(data!, hasItems);
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
    final widgets = <Widget>[];

    void addCategory(String title, List<Setting> settings) {
      if (settings.isEmpty) return;
      widgets.add(settingsCategoryTitle(context, title));
      widgets.addAll(settings.map((setting) => setting.toListTile()));
    }

    addCategory("Accepted", acceptedTasks(context, data));
    addCategory("Rejected", rejectedTasks(context, data));

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets),
    );
  }

  List<Setting> acceptedTasks(BuildContext context, RequiredData data) {
    return [
      if (data.contentBotInitial) moderateImagesInitialBotAcceptedSetting(context),
      if (data.contentBot) moderateImagesNormalBotAcceptedSetting(context),
      if (data.profileNamesBot) moderateProfileNamesBotAcceptedSetting(context),
      if (data.profileTextsBot) moderateProfileTextsBotAcceptedSetting(context),
      if (data.reportsBot) processReportsBotAcceptedSetting(context),
    ];
  }

  List<Setting> rejectedTasks(BuildContext context, RequiredData data) {
    return [
      if (data.contentBotInitialRejected) moderateImagesInitialBotRejectedSetting(context),
      if (data.contentBotRejected) moderateImagesNormalBotRejectedSetting(context),
      if (data.profileNamesBotRejected) moderateProfileNamesBotRejectedSetting(context),
      if (data.profileTextsBotRejected) moderateProfileTextsBotRejectedSetting(context),
      if (data.reportsBotRejected) processReportsBotRejectedSetting(context),
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

  Setting moderateImagesInitialBotAcceptedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (initial, bot accepted)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.initial,
          queueType: MediaContentModerationQueueType.acceptedByAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.initial,
          MediaContentModerationQueueType.acceptedByAdminBot,
          (data, hasItems) => data.copyWith(contentBotInitial: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesInitialBotRejectedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (initial, bot rejected)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.initial,
          queueType: MediaContentModerationQueueType.rejectedByAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.initial,
          MediaContentModerationQueueType.rejectedByAdminBot,
          (data, hasItems) => data.copyWith(contentBotInitialRejected: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesNormalBotAcceptedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (normal, bot accepted)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.normal,
          queueType: MediaContentModerationQueueType.acceptedByAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.normal,
          MediaContentModerationQueueType.acceptedByAdminBot,
          (data, hasItems) => data.copyWith(contentBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateImagesNormalBotRejectedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.image,
      "Moderate images (normal, bot rejected)",
      () => _openAndReload(
        context,
        ModerateImagesPage(
          r,
          moderationType: MediaContentModerationType.normal,
          queueType: MediaContentModerationQueueType.rejectedByAdminBot,
        ),
        () => _reloadMediaTask(
          MediaContentModerationType.normal,
          MediaContentModerationQueueType.rejectedByAdminBot,
          (data, hasItems) => data.copyWith(contentBotRejected: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileNamesBotAcceptedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile names (bot accepted)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileName,
          queueType: ProfileStringModerationQueueType.acceptedByAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileName,
          ProfileStringModerationQueueType.acceptedByAdminBot,
          (data, hasItems) => data.copyWith(profileNamesBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileNamesBotRejectedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile names (bot rejected)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileName,
          queueType: ProfileStringModerationQueueType.rejectedByAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileName,
          ProfileStringModerationQueueType.rejectedByAdminBot,
          (data, hasItems) => data.copyWith(profileNamesBotRejected: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileTextsBotAcceptedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile texts (bot accepted)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileText,
          queueType: ProfileStringModerationQueueType.acceptedByAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileText,
          ProfileStringModerationQueueType.acceptedByAdminBot,
          (data, hasItems) => data.copyWith(profileTextsBot: hasItems),
        ),
      ),
    );
  }

  Setting moderateProfileTextsBotRejectedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.text_fields,
      "Moderate profile texts (bot rejected)",
      () => _openAndReload(
        context,
        ModerateProfileStringsPage(
          r,
          contentType: ProfileStringModerationContentType.profileText,
          queueType: ProfileStringModerationQueueType.rejectedByAdminBot,
        ),
        () => _reloadProfileStringTask(
          ProfileStringModerationContentType.profileText,
          ProfileStringModerationQueueType.rejectedByAdminBot,
          (data, hasItems) => data.copyWith(profileTextsBotRejected: hasItems),
        ),
      ),
    );
  }

  Setting processReportsBotAcceptedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.report,
      "Process reports (bot accepted)",
      () => _openAndReload(
        context,
        ProcessReportsPage(r, queueType: ReportQueueType.acceptedByAdminBot),
        () => _reloadReportsTask(
          ReportQueueType.acceptedByAdminBot,
          (data, hasItems) => data.copyWith(reportsBot: hasItems),
        ),
      ),
    );
  }

  Setting processReportsBotRejectedSetting(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.report,
      "Process reports (bot rejected)",
      () => _openAndReload(
        context,
        ProcessReportsPage(r, queueType: ReportQueueType.rejectedByAdminBot),
        () => _reloadReportsTask(
          ReportQueueType.rejectedByAdminBot,
          (data, hasItems) => data.copyWith(reportsBotRejected: hasItems),
        ),
      ),
    );
  }
}
