import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_custom.widget.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("LoadingPage");

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    var l10n = AppLocalizations.of(
      context,
    )!;

    final padding = Theme.of(
          context,
        ).textTheme.titleLarge?.fontSize ??
        0.0;

    return Scaffold(
      appBar: AppBarCustomWidget(),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: padding,
          children: [
            const CircularProgressIndicator(),
            ElevatedButton(
              onPressed: () => onCancelPressed(
                context: context,
              ),
              child: Text(
                l10n.cancel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCancelPressed({
    required BuildContext context,
  }) {
    // TODO
    // _log("onCancelPressed").print();

    // final loadingBloc = Provider.of<LoadingBloc>(
    //   context,
    //   listen: false,
    // );

    // loadingBloc.cancelRequest();
  }
}
