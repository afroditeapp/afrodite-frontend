import 'package:app/ui/normal/chat/chat_list/lazy_quotation.dart';
import 'package:app/ui/normal/chat/chat_list/reply_target_controller.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;

/// A composer widget that animates the display of a reply target above the input field.
/// This widget listens to a [ReplyTargetController] and animates the reply widget in/out
/// when the reply target changes.
class AnimatedComposer extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final ReplyTargetController replyTargetController;
  final String hintText;

  const AnimatedComposer({
    required this.textEditingController,
    required this.focusNode,
    required this.replyTargetController,
    required this.hintText,
    super.key,
  });

  @override
  State<AnimatedComposer> createState() => _AnimatedComposerState();
}

class _AnimatedComposerState extends State<AnimatedComposer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  MessageEntry? _uiReplyTarget;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
          ..addListener(() {
            // Make message list to follow animation
            setState(() {});
          });

    // Listen to controller changes
    widget.replyTargetController.addListener(_onReplyTargetChanged);
    _uiReplyTarget = widget.replyTargetController.replyTarget;
    if (_uiReplyTarget != null) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    widget.replyTargetController.removeListener(_onReplyTargetChanged);
    _animationController.dispose();
    super.dispose();
  }

  void _onReplyTargetChanged() {
    final newTarget = widget.replyTargetController.replyTarget;
    if (newTarget != null) {
      setState(() {
        _uiReplyTarget = newTarget;
      });
      _animationController.forward();
      // Focus the text field and open keyboard
      widget.focusNode.requestFocus();
    } else {
      _animationController.reverse().then((_) {
        if (mounted && widget.replyTargetController.replyTarget == null) {
          setState(() {
            _uiReplyTarget = null;
          });
        }
      });
    }
  }

  void _clearReplyTarget() {
    widget.replyTargetController.clearReplyTarget();
  }

  @override
  Widget build(BuildContext context) {
    Widget topWidget = const SizedBox.shrink();
    if (_uiReplyTarget != null) {
      topWidget = Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: buildQuotation(
                context,
                _uiReplyTarget!,
                widget.replyTargetController.profileEntry,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _clearReplyTarget,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    }

    return chat_ui.Composer(
      textEditingController: widget.textEditingController,
      focusNode: widget.focusNode,
      inputClearMode: chat_ui.InputClearMode.never,
      hintText: widget.hintText,
      topWidget: SizeTransition(
        sizeFactor: CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        child: topWidget,
      ),
    );
  }
}
