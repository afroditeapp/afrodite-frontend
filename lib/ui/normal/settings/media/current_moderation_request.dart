

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/media/new_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui/normal/settings/media/new_moderation_request.dart';
import 'package:pihka_frontend/ui/normal/settings/media/select_content.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/view_image_screen.dart';
import 'package:pihka_frontend/utils/api.dart';

class CurrentModerationRequestScreen extends StatefulWidget {
  final CurrentModerationRequestBloc currentModerationRequestBloc;
  const CurrentModerationRequestScreen({
    required this.currentModerationRequestBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentModerationRequestScreen> createState() => _CurrentModerationRequestScreenState();
}

class _CurrentModerationRequestScreenState extends State<CurrentModerationRequestScreen> {

  @override
  void initState() {
    super.initState();
    widget.currentModerationRequestBloc.add(Reload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.current_moderation_request_screen_title),
        actions: [
           BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
            builder: (context, state) {
              final request = state.moderationRequest;
              if (request == null || request.isOngoing()) {
                return const SizedBox.shrink();
              } else {
                return IconButton(
                  icon: const Icon(Icons.add_a_photo_rounded),
                  onPressed: () => _openNewModerationRequestInitialOrAfter(context),
                  tooltip: context.strings.current_moderation_request_screen_new_request_action,
                );
              }
            }
          )
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, aState) {
          return BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
            builder: (context, state) {
              final accountId = aState.accountId;
              final moderationRequest = state.moderationRequest;
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isError || moderationRequest == null || accountId == null) {
                return Center(child: Text(context.strings.generic_error));
              } else {
                return selectContentPage(
                  context,
                  accountId,
                  moderationRequest,
                );
              }
            }
          );
        }
      )
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    ModerationRequest request,
  ) {
    final List<Widget> gridWidgets = [];

    final moderationRequestContent = request.contentList();

    if (request.isOngoing()) {
      gridWidgets.addAll(
        moderationRequestContent.map((e) => buildPendingImg(
          context,
          accountId,
          e,
          onTap: () => openViewImageScreenForAccountImage(context, accountId, e),
        ))
      );

    } else {
      gridWidgets.addAll(
        moderationRequestContent.map((e) => buildAvailableImg(
          context,
          accountId,
          e,
          onTap: () => openViewImageScreenForAccountImage(context, accountId, e)
        ))
      );
    }

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: gridWidgets,
    );

    final List<Widget> widgets = [];

    widgets.add(Padding(
      padding: const EdgeInsets.only(
        left: COMMON_SCREEN_EDGE_PADDING,
        right: COMMON_SCREEN_EDGE_PADDING,
        top: COMMON_SCREEN_EDGE_PADDING,
        bottom: 16,
      ),
      child: statusInfo(context, request),
    ));

    if (request.state == ModerationRequestState.denied) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            left: COMMON_SCREEN_EDGE_PADDING,
            right: COMMON_SCREEN_EDGE_PADDING,
            bottom: 16,
          ),
          child: ElevatedButton.icon(
            onPressed: () => _openNewModerationRequestInitialOrAfter(context),
            icon: const Icon(Icons.add_a_photo_rounded),
            label: Text(context.strings.current_moderation_request_screen_new_request_action_when_current_request_denied),
          ),
        )
      );
    }

    widgets.add(grid);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  Widget statusInfo(BuildContext context, ModerationRequest moderationRequest) {
    final IconData iconData;
    final Widget statusText;
    final Color statusColor;
    Widget queuePositionText = const SizedBox.shrink();
    if (moderationRequest.state == ModerationRequestState.accepted) {
      iconData = Icons.check_rounded;
      statusText = Text(context.strings.current_moderation_request_screen_request_accepted);
      statusColor = Colors.green;
    } else if (moderationRequest.state == ModerationRequestState.denied) {
      iconData = Icons.block_rounded;
      statusText = Text(context.strings.current_moderation_request_screen_request_denied);
      statusColor = Colors.red;
    } else {
      iconData = Icons.hourglass_top_rounded;
      statusText = Text(context.strings.current_moderation_request_screen_request_waiting);
      statusColor = Colors.black54;
      final position = moderationRequest.waitingPosition ?? 0;
      queuePositionText = Text(
        context.strings.current_moderation_request_screen_moderation_queue_position(position.toString())
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              statusText,
              queuePositionText,
            ]
          )
        ),
        const Padding(padding: EdgeInsets.all(8)),
        Icon(
          iconData,
          color: statusColor,
          size: 48,
        ),
      ],
    );
  }

  void _openNewModerationRequestInitialOrAfter(BuildContext context) async {
    final isInitialModerationOngoing = context.read<AccountBloc>().state.isInitialModerationOngoing();
    if (isInitialModerationOngoing) {
      // TODO
    } else {
      final bloc = context.read<CurrentModerationRequestBloc>();
      final list = await openNewModerationRequest(context);
      if (list != null && list.isNotEmpty) {
        bloc.add(SendNewModerationRequest(list));
      }
    }
  }
}


Future<List<ContentId>?> openNewModerationRequest(BuildContext context) async {
  final bloc = context.read<NewModerationRequestBloc>();
  final list = await Navigator.push(
    context,
    MaterialPageRoute<List<ContentId>?>(
      builder: (_) => NewModerationRequestScreen(newModerationRequestBloc: bloc)
    )
  );

  return list;
}
