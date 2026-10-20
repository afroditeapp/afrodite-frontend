import 'dart:async';

import 'package:app/ui_utils/dialog.dart';
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
          _showLoadingDialog<B, S>(context, widget, widget.dialogVisibilityGetter);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

void _showLoadingDialog<B extends StateStreamable<S>, S>(
  BuildContext context,
  ProgressDialogOpener<B, S> widget,
  bool Function(S) dialogVisibilityGetter,
) {
  MyNavigator.showDialog<()>(
    context: context,
    page: LoadingDialogPage(
      builder: (context, closer) {
        return _loadingDialogContent<B, S>(widget, closer, dialogVisibilityGetter, context);
      },
    ),
  );
}

Widget _loadingDialogContent<B extends StateStreamable<S>, S>(
  ProgressDialogOpener<B, S> widget,
  PageCloser<()> closer,
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
          BlocBuilder<B, S>(
            builder: (context, state) {
              if (!dialogVisibilityGetter(state)) {
                Future.delayed(Duration.zero, () {
                  if (context.mounted) {
                    closer.close(context, ());
                  }
                });
              }
              final text = widget.loadingText;
              final b = widget.stateInfoBuilder;
              if (text != null) {
                return Text(text);
              } else if (b != null) {
                return b(context, state);
              } else {
                return const SizedBox.shrink();
              }
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
