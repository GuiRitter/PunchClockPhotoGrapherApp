import 'package:flutter/material.dart';

class ElevatedButtonWithLoading extends StatefulWidget {
  final Function beforeLoading;
  final Function duringLoading;
  final Function afterLoading;
  final String text;

  const ElevatedButtonWithLoading({
    super.key,
    required this.beforeLoading,
    required this.duringLoading,
    required this.afterLoading,
    required this.text,
  });

  @override
  State<ElevatedButtonWithLoading> createState() =>
      _ElevatedButtonWithLoadingState();
}

class _ElevatedButtonWithLoadingState extends State<ElevatedButtonWithLoading> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              var beforeData = await widget.beforeLoading();

              setState(() {
                _isLoading = true;
              });

              var duringData = await widget.duringLoading(beforeData);

              setState(() {
                _isLoading = false;
              });

              widget.afterLoading(beforeData, duringData);
            },
            child: Text(
              widget.text,
            ),
          );
  }
}
