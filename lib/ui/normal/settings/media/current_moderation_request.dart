

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/login.dart';
import 'package:app/logic/media/initial_content_moderation.dart';
import 'package:app/logic/media/new_moderation_request.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/login.dart';
import 'package:app/model/freezed/logic/media/initial_content_moderation.dart';
import 'package:app/ui/normal/settings/media/retry_initial_setup_images.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';

class CurrentModerationRequestScreenOpener extends StatelessWidget {
  const CurrentModerationRequestScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    // return CurrentModerationRequestScreen(
    //   currentModerationRequestBloc: context.read<CurrentModerationRequestBloc>()
    // );
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

// class CurrentModerationRequestScreen extends StatefulWidget {
//   final CurrentModerationRequestBloc currentModerationRequestBloc;
//   const CurrentModerationRequestScreen({
//     required this.currentModerationRequestBloc,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CurrentModerationRequestScreen> createState() => _CurrentModerationRequestScreenState();
// }

// class _CurrentModerationRequestScreenState extends State<CurrentModerationRequestScreen> {

//   @override
//   void initState() {
//     super.initState();
//     widget.currentModerationRequestBloc.add(ReloadOnceConnected());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.strings.current_moderation_request_screen_title),
//         actions: [
//           BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
//             builder: (context, state) {
//               final request = state.moderationRequest;
//               if (state.isLoading || state.isError || (request != null && request.isOngoing())) {
//                 return const SizedBox.shrink();
//               } else {
//                 return IconButton(
//                   icon: const Icon(Icons.add_a_photo_rounded),
//                   onPressed: () => _openNewModerationRequestInitialOrAfter(context),
//                   tooltip: context.strings.current_moderation_request_screen_new_request_action,
//                 );
//               }
//             }
//           ),
//           BlocBuilder<AccountBloc, AccountBlocData>(
//             builder: (context, aState) {
//               return BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
//                 builder: (context, state) {
//                   final request = state.moderationRequest;
//                   if (request == null || request.state != ModerationRequestState.waiting || aState.isInitialModerationOngoing()) {
//                     return const SizedBox.shrink();
//                   } else {
//                     return IconButton(
//                       icon: const Icon(Icons.delete_rounded),
//                       onPressed: () async {
//                         final accepted = await showConfirmDialog(context, context.strings.current_moderation_request_screen_delete_request_dialog_title);
//                         if (accepted == true) {
//                           widget.currentModerationRequestBloc.add(DeleteCurrentModerationRequest());
//                         }
//                       },
//                       tooltip: context.strings.current_moderation_request_screen_delete_request_action,
//                     );
//                   }
//                 }
//               );
//             }
//           ),
//         ],
//       ),
//       body: BlocBuilder<LoginBloc, LoginBlocData>(
//         builder: (context, lState) {
//           return BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
//             builder: (context, state) {
//               final accountId = lState.accountId;
//               final moderationRequest = state.moderationRequest;
//               if (state.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state.isError || accountId == null) {
//                 return Center(child: Text(context.strings.generic_error));
//               } else if (moderationRequest == null) {
//                 return Center(child: Text(context.strings.current_moderation_request_screen_no_request));
//               } else {
//                 return selectContentPage(
//                   context,
//                   accountId,
//                   moderationRequest,
//                 );
//               }
//             }
//           );
//         }
//       )
//     );
//   }

//   Widget selectContentPage(
//     BuildContext context,
//     AccountId accountId,
//     ModerationRequest request,
//   ) {
//     final List<Widget> gridWidgets = [];

//     final moderationRequestContent = request.contentList();

//     if (request.isOngoing()) {
//       gridWidgets.addAll(
//         moderationRequestContent.map((e) => buildPendingImg(
//           context,
//           accountId,
//           e,
//           onTap: () => openViewImageScreenForAccountImage(context, accountId, e),
//         ))
//       );

//     } else {
//       gridWidgets.addAll(
//         moderationRequestContent.map((e) => buildAvailableImg(
//           context,
//           accountId,
//           e,
//           onTap: () => openViewImageScreenForAccountImage(context, accountId, e)
//         ))
//       );
//     }

//     final grid = GridView.count(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       crossAxisCount: 2,
//       children: gridWidgets,
//     );

//     final List<Widget> widgets = [];

//     widgets.add(Padding(
//       padding: const EdgeInsets.only(
//         left: COMMON_SCREEN_EDGE_PADDING,
//         right: COMMON_SCREEN_EDGE_PADDING,
//         top: COMMON_SCREEN_EDGE_PADDING,
//         bottom: 16,
//       ),
//       child: statusInfo(context, request),
//     ));

//     if (request.state == ModerationRequestState.rejected) {
//       widgets.add(
//         retryModerationRequestButton(context)
//       );
//     }

//     widgets.add(grid);

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: widgets,
//       ),
//     );
//   }

//   Widget statusInfo(BuildContext context, ModerationRequest moderationRequest) {
//     final IconData iconData;
//     final Widget statusText;
//     final Color? statusColor;
//     Widget queuePositionText = const SizedBox.shrink();
//     if (moderationRequest.state == ModerationRequestState.accepted) {
//       iconData = Icons.check_rounded;
//       statusText = Text(context.strings.current_moderation_request_screen_request_accepted);
//       statusColor = Colors.green;
//     } else if (moderationRequest.state == ModerationRequestState.rejected) {
//       iconData = Icons.block_rounded;
//       statusText = Text(context.strings.current_moderation_request_screen_request_rejected);
//       statusColor = Colors.red;
//     } else {
//       iconData = Icons.hourglass_top_rounded;
//       statusText = Text(context.strings.current_moderation_request_screen_request_waiting);
//       statusColor = null;
//       final position = moderationRequest.waitingPosition ?? 0;
//       queuePositionText = Text(
//         context.strings.current_moderation_request_screen_moderation_queue_position(position.toString())
//       );
//     }

//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               statusText,
//               queuePositionText,
//             ]
//           )
//         ),
//         const Padding(padding: EdgeInsets.all(8)),
//         Icon(
//           iconData,
//           color: statusColor,
//           size: 48,
//         ),
//       ],
//     );
//   }
// }

Widget retryModerationRequestButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: COMMON_SCREEN_EDGE_PADDING,
      right: COMMON_SCREEN_EDGE_PADDING,
      bottom: 16,
    ),
    child: ElevatedButton.icon(
      onPressed: () => _openNewModerationRequestInitialOrAfter(context),
      icon: const Icon(Icons.add_a_photo_rounded),
      label: Text(context.strings.current_moderation_request_screen_new_request_action_when_current_request_rejected),
    ),
  );
}

void _openNewModerationRequestInitialOrAfter(BuildContext context) async {
  final isInitialModerationOngoing = context.read<AccountBloc>().state.isInitialModerationOngoing();
  // if (isInitialModerationOngoing) {
  //   final bloc = context.read<CurrentModerationRequestBloc>();
  //   final newImgs = await openRetryInitialSetupImages(context);
  //   if (newImgs != null) {
  //     bloc.add(SendRetryInitialSetupImages(newImgs));
  //   }
  // } else {
  //   final bloc = context.read<CurrentModerationRequestBloc>();
  //   final list = await openNewModerationRequest(context);
  //   if (list != null && list.isNotEmpty) {
  //     bloc.add(SendNewModerationRequest(list));
  //   }
  // }
}

// Future<List<ContentId>?> openNewModerationRequest(BuildContext context) async {
//   final bloc = context.read<NewModerationRequestBloc>();
//   final list = await MyNavigator.push(
//     context,
//     MaterialPage<List<ContentId>?>(
//       child: NewModerationRequestScreen(newModerationRequestBloc: bloc)
//     )
//   );

//   return list;
// }
