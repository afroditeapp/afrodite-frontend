import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';

class ProgressDialogOpener<B extends StateStreamable<S>, S> extends StatefulWidget {
  /// Listener which returns true if the dialog should be opened and
  /// false if it should be closed.
  final bool Function(S) dialogVisibilityGetter;

  /// If null only the circular progress indicator is shown.
  final String? loadingText;

  /// Display widget where info text would be shown.
  final Widget Function(BuildContext, S)? stateInfoBuilder;
  const ProgressDialogOpener({
    required this.dialogVisibilityGetter,
    this.stateInfoBuilder,
    this.loadingText,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProgressDialogOpenerState<B, S>();
}

class _ProgressDialogOpenerState<B extends StateStreamable<S>, S>
    extends State<ProgressDialogOpener<B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      buildWhen: (previous, current) =>
          widget.dialogVisibilityGetter(previous) != widget.dialogVisibilityGetter(current),
      builder: (context, state) {
        if (widget.dialogVisibilityGetter(state)) {
          openDialog(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  void openDialog(BuildContext context, S state) async {
    final Widget w;
    final text = widget.loadingText;
    final b = widget.stateInfoBuilder;
    if (text != null) {
      w = Text(text);
    } else if (b != null) {
      w = b(context, state);
    } else {
      w = const SizedBox.shrink();
    }

    _showLoadingDialog<B, S>(context, w, widget.dialogVisibilityGetter);
  }
}

void _showLoadingDialog<B extends StateStreamable<S>, S>(
  BuildContext context,
  Widget loadingInfo,
  bool Function(S) dialogVisibilityGetter,
) {
  final PageKey pageKey = PageKey();
  MyNavigator.showDialog<void>(
    context: context,
    pageKey: pageKey,
    barrierDismissable: false,
    builder: (context) {
      return _loadingDialogContent<B, S>(loadingInfo, pageKey, dialogVisibilityGetter, context);
    },
  );
}

Widget _loadingDialogContent<B extends StateStreamable<S>, S>(
  Widget loadingInfo,
  PageKey pageKey,
  bool Function(S) dialogVisibilityGetter,
  BuildContext context,
) {
  return PopScope(
    canPop: false,
    child: AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          commonLoadingDialogIndicator(),
          loadingInfo,
          // Use BlocBuilder (instead of BlocListener) as it gets the initial state as well.
          BlocBuilder<B, S>(
            buildWhen: (previous, current) =>
                dialogVisibilityGetter(previous) != dialogVisibilityGetter(current),
            builder: (context, state) {
              if (!dialogVisibilityGetter(state)) {
                Future.delayed(Duration.zero, () {
                  if (context.mounted) {
                    MyNavigator.removePage(context, pageKey);
                  }
                });
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    ),
  );
}

Widget commonLoadingDialogIndicator() {
  return const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator());
}
