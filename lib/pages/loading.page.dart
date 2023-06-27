import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  // TODO cancel request

  @override
  Widget build(
    BuildContext context,
  ) {
    var l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(
                context,
              )!
                  .title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall,
            ),
            Text(
              l10n.loading,
            ),
          ],
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
