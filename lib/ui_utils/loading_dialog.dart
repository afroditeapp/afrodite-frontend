


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressDialogBlocListener<B extends StateStreamable<S>, S> extends StatefulWidget {
  final Widget child;
  /// Listener which returns true if the dialog should be opened and
  /// false if it should be closed.
  final bool Function(BuildContext, S) dialogVisibilityGetter;
  /// If null only the circular progress indicator is shown.
  final String? loadingText;
  /// Display widget where info text would be shown.
  final Widget Function(BuildContext, S)? stateInfoBuilder;
  const ProgressDialogBlocListener({
    required this.child,
    required this.dialogVisibilityGetter,
    this.stateInfoBuilder,
    this.loadingText,
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProgressDialogBlocListenerState<B, S>();
}

class _ProgressDialogBlocListenerState<B extends StateStreamable<S>, S> extends State<ProgressDialogBlocListener<B, S>> {
  bool dialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) async {
        if (widget.dialogVisibilityGetter(context, state) && !dialogOpen) {
          dialogOpen = true;

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

          await _showLoadingDialog<B, S>(
            context,
            w,
            widget.dialogVisibilityGetter,
          );

          dialogOpen = false;
        }
      },
      child: widget.child,
    );
  }
}

Future<void> _showLoadingDialog<B extends StateStreamable<S>, S>(
  BuildContext context,
  Widget loadingInfo,
  bool Function(BuildContext, S) dialogVisibilityGetter
) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          content: BlocListener<B, S>(
            listenWhen: (previous, current) => dialogVisibilityGetter(context, previous) != dialogVisibilityGetter(context, current),
            listener: (context, state) {
              if (!dialogVisibilityGetter(context, state)) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                loadingInfo,
              ],
            ),
          ),
        ),
      );
    },
  );
}
