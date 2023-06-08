import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/models/on_pressed_step_data.dart';

class ButtonWithLoading extends StatefulWidget {
  final Widget Function({
    required VoidCallback onPressed,
    required Widget child,
  }) buttonBuilder;

  final Widget child;
  final Widget loadingIndicator;

  final Future<OnPressedStepData> Function() beforeLoading;

  final Future<OnPressedStepData> Function(
    OnPressedStepData beforeData,
  ) duringLoading;

  final void Function(
    OnPressedStepData beforeData,
    OnPressedStepData duringData,
  ) afterLoading;

  const ButtonWithLoading({
    super.key,
    required this.child,
    required this.loadingIndicator,
    required this.buttonBuilder,
    required this.beforeLoading,
    required this.duringLoading,
    required this.afterLoading,
  });

  @override
  State<ButtonWithLoading> createState() => _ButtonWithLoadingState();
}

class _ButtonWithLoadingState extends State<ButtonWithLoading> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) => widget.buttonBuilder(
        child: _isLoading ? widget.loadingIndicator : widget.child,
        onPressed: () async {
          if (_isLoading) {
            return;
          }

          var beforeData = await widget.beforeLoading();

          if (!beforeData.shouldContinue) {
            return;
          }

          setState(() {
            _isLoading = true;
          });

          var duringData = await widget.duringLoading(beforeData);

          setState(() {
            _isLoading = false;
          });

          if (!duringData.shouldContinue) {
            return;
          }

          widget.afterLoading(beforeData, duringData);
        },
      );
}
