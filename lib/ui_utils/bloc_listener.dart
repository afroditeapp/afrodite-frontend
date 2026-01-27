import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenerWithInitialValue<B extends StateStreamable<S>, S> extends StatefulWidget {
  const BlocListenerWithInitialValue({
    required this.listener,
    this.listenWhen,
    this.child,
    super.key,
  });

  final BlocWidgetListener<S> listener;
  final BlocListenerCondition<S>? listenWhen;
  final Widget? child;

  @override
  State<BlocListenerWithInitialValue<B, S>> createState() =>
      _BlocListenerWithInitialValueState<B, S>();
}

class _BlocListenerWithInitialValueState<B extends StateStreamable<S>, S>
    extends State<BlocListenerWithInitialValue<B, S>> {
  StreamSubscription<S>? _subscription;
  late B _bloc;
  late S _previousState;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  void _subscribe() {
    _bloc = context.read<B>();
    _previousState = _bloc.state;

    widget.listener(context, _previousState);

    _subscription = _bloc.stream.listen((state) {
      if (!mounted) {
        return;
      }
      if (widget.listenWhen?.call(_previousState, state) ?? true) {
        widget.listener(context, state);
      }
      _previousState = state;
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child ?? const SizedBox.shrink();
}
