


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressDialogBlocListener<B extends StateStreamable<S>, S> extends StatefulWidget {
  final Widget child;
  /// Listener which returns true if the dialog should be opened and
  /// false if it should be closed.
  final bool Function(BuildContext, S) dialogVisibilityGetter;
  final String loadingText;
  const ProgressDialogBlocListener({required this.child, required this.dialogVisibilityGetter, required this.loadingText, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProgressDialogBlocListenerState<B, S>();
}

class _ProgressDialogBlocListenerState<B extends StateStreamable<S>, S> extends State<ProgressDialogBlocListener<B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        if (widget.dialogVisibilityGetter(context, state)) {
          _showLoadingDialog<B, S>(
            context,
            widget.loadingText,
            widget.dialogVisibilityGetter,
          );
        }
      },
      child: widget.child,
    );
  }
}

void _showLoadingDialog<B extends StateStreamable<S>, S>(
  BuildContext context,
  String loadingText,
  bool Function(BuildContext, S) dialogVisibilityGetter
) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: BlocListener<B, S>(
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
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(loadingText),
              ),
            ],
          ),
        ),
      );
    },
  );
}
