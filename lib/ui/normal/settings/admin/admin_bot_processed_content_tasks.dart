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

    final MediaContentModerationQueuePage? contentBotInitial;
    final MediaContentModerationQueuePage? contentBotInitialRejected;
    final MediaContentModerationQueuePage? contentBot;
    final MediaContentModerationQueuePage? contentBotRejected;
    if (permissions.adminModerateMediaContent) {
      contentBotInitial = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.initial,
              MediaContentModerationQueueType.acceptedByAdminBot,
            ),
          )
          .ok();
      contentBotInitialRejected = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.initial,
              MediaContentModerationQueueType.rejectedByAdminBot,
            ),
          )
          .ok();
      contentBot = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.normal,
              MediaContentModerationQueueType.acceptedByAdminBot,
            ),
          )
          .ok();
      contentBotRejected = await widget.api
          .mediaAdmin(
            (api) => api.getMediaContentModerationQueuePage(
              MediaContentType.jpegImage,
              MediaContentModerationType.normal,
              MediaContentModerationQueueType.rejectedByAdminBot,
            ),
          )
          .ok();
    } else {
      final empty = MediaContentModerationQueuePage();
      contentBotInitial = empty;
      contentBotInitialRejected = empty;
      contentBot = empty;
      contentBotRejected = empty;
    }

    final ProfileStringModerationQueuePage? profileNamesBot;
    final ProfileStringModerationQueuePage? profileNamesBotRejected;
    if (permissions.adminModerateProfileNames) {
      profileNamesBot = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileName,
              ProfileStringModerationQueueType.acceptedByAdminBot,
            ),
          )
          .ok();
      profileNamesBotRejected = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileName,
              ProfileStringModerationQueueType.rejectedByAdminBot,
            ),
          )
          .ok();
    } else {
      profileNamesBot = ProfileStringModerationQueuePage();
      profileNamesBotRejected = ProfileStringModerationQueuePage();
    }

    final ProfileStringModerationQueuePage? profileTextsBot;
    final ProfileStringModerationQueuePage? profileTextsBotRejected;
    if (permissions.adminModerateProfileTexts) {
      profileTextsBot = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileText,
              ProfileStringModerationQueueType.acceptedByAdminBot,
            ),
          )
          .ok();
      profileTextsBotRejected = await widget.api
          .profileAdmin(
            (api) => api.getProfileStringModerationQueuePage(
              ProfileStringModerationContentType.profileText,
              ProfileStringModerationQueueType.rejectedByAdminBot,
            ),
          )
          .ok();
    } else {
      profileTextsBot = ProfileStringModerationQueuePage();
      profileTextsBotRejected = ProfileStringModerationQueuePage();
    }

    final GetReportList? reportsBot;
    final GetReportList? reportsBotRejected;
    if (permissions.adminProcessReports) {
      reportsBot = await widget.api
          .commonAdmin(
            (api) => api.postGetReportQueuePage(
              GetReportQueuePage(queueType: ReportQueueType.acceptedByAdminBot),
            ),
          )
          .ok();
      reportsBotRejected = await widget.api
          .commonAdmin(
            (api) => api.postGetReportQueuePage(
              GetReportQueuePage(queueType: ReportQueueType.rejectedByAdminBot),
            ),
          )
          .ok();
    } else {
      reportsBot = GetReportList();
      reportsBotRejected = GetReportList();
    }

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
          contentBotInitial: contentBotInitial?.values.isNotEmpty ?? false,
          contentBotInitialRejected: contentBotInitialRejected?.values.isNotEmpty ?? false,
          contentBot: contentBot?.values.isNotEmpty ?? false,
          contentBotRejected: contentBotRejected?.values.isNotEmpty ?? false,
          profileNamesBot: profileNamesBot?.values.isNotEmpty ?? false,
          profileNamesBotRejected: profileNamesBotRejected?.values.isNotEmpty ?? false,
          profileTextsBot: profileTextsBot?.values.isNotEmpty ?? false,
          profileTextsBotRejected: profileTextsBotRejected?.values.isNotEmpty ?? false,
          reportsBot: reportsBot?.values.isNotEmpty ?? false,
          reportsBotRejected: reportsBotRejected?.values.isNotEmpty ?? false,
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
}

Setting moderateImagesInitialBotAcceptedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.image,
    "Moderate images (initial, bot accepted)",
    () => MyNavigator.pushLimited(
      context,
      ModerateImagesPage(
        r,
        moderationType: MediaContentModerationType.initial,
        queueType: MediaContentModerationQueueType.acceptedByAdminBot,
      ),
    ),
  );
}

Setting moderateImagesInitialBotRejectedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.image,
    "Moderate images (initial, bot rejected)",
    () => MyNavigator.pushLimited(
      context,
      ModerateImagesPage(
        r,
        moderationType: MediaContentModerationType.initial,
        queueType: MediaContentModerationQueueType.rejectedByAdminBot,
      ),
    ),
  );
}

Setting moderateImagesNormalBotAcceptedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.image,
    "Moderate images (normal, bot accepted)",
    () => MyNavigator.pushLimited(
      context,
      ModerateImagesPage(
        r,
        moderationType: MediaContentModerationType.normal,
        queueType: MediaContentModerationQueueType.acceptedByAdminBot,
      ),
    ),
  );
}

Setting moderateImagesNormalBotRejectedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.image,
    "Moderate images (normal, bot rejected)",
    () => MyNavigator.pushLimited(
      context,
      ModerateImagesPage(
        r,
        moderationType: MediaContentModerationType.normal,
        queueType: MediaContentModerationQueueType.rejectedByAdminBot,
      ),
    ),
  );
}

Setting moderateProfileNamesBotAcceptedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.text_fields,
    "Moderate profile names (bot accepted)",
    () => MyNavigator.pushLimited(
      context,
      ModerateProfileStringsPage(
        r,
        contentType: ProfileStringModerationContentType.profileName,
        queueType: ProfileStringModerationQueueType.acceptedByAdminBot,
      ),
    ),
  );
}

Setting moderateProfileNamesBotRejectedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.text_fields,
    "Moderate profile names (bot rejected)",
    () => MyNavigator.pushLimited(
      context,
      ModerateProfileStringsPage(
        r,
        contentType: ProfileStringModerationContentType.profileName,
        queueType: ProfileStringModerationQueueType.rejectedByAdminBot,
      ),
    ),
  );
}

Setting moderateProfileTextsBotAcceptedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.text_fields,
    "Moderate profile texts (bot accepted)",
    () => MyNavigator.pushLimited(
      context,
      ModerateProfileStringsPage(
        r,
        contentType: ProfileStringModerationContentType.profileText,
        queueType: ProfileStringModerationQueueType.acceptedByAdminBot,
      ),
    ),
  );
}

Setting moderateProfileTextsBotRejectedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.text_fields,
    "Moderate profile texts (bot rejected)",
    () => MyNavigator.pushLimited(
      context,
      ModerateProfileStringsPage(
        r,
        contentType: ProfileStringModerationContentType.profileText,
        queueType: ProfileStringModerationQueueType.rejectedByAdminBot,
      ),
    ),
  );
}

Setting processReportsBotAcceptedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.report,
    "Process reports (bot accepted)",
    () => MyNavigator.pushLimited(
      context,
      ProcessReportsPage(r, queueType: ReportQueueType.acceptedByAdminBot),
    ),
  );
}

Setting processReportsBotRejectedSetting(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return Setting.createSetting(
    Icons.report,
    "Process reports (bot rejected)",
    () => MyNavigator.pushLimited(
      context,
      ProcessReportsPage(r, queueType: ReportQueueType.rejectedByAdminBot),
    ),
  );
}
