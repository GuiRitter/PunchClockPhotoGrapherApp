import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' show l10n;
import 'package:punch_clock_photo_grapher_app/models/list.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_signed_in.widget.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/body.widget.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("HomePage");

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log("build").print();

    return BodyWidget(
      usePadding: false,
      appBar: const AppBarSignedInWidget(),
      body: StoreConnector<StateModel, ListModel?>(
        distinct: true,
        converter: ListModel.select,
        builder: connectorBuilder,
      ),
    );
  }

  Widget connectorBuilder(
    BuildContext context,
    ListModel? list,
  ) {
    _log("connectorBuilder").map("list", list).print();

    final mediaSize = MediaQuery.of(
      context,
    ).size;

    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    Widget body;

    if (list == null) {
      body = Text(
        l10n.getNotCalled,
      );
    } else if (list.weekList.isEmpty) {
      body = Text(
        l10n.noPhoto,
      );
    } else {
      body = Text(
        list.weekList.toString(),
      );
    }

    return SizedBox(
      height: mediaSize.height,
      width: mediaSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: body,
            ),
          ),
          BottomAppBar(
            color: theme.scaffoldBackgroundColor,
            padding: EdgeInsets.all(
              fieldPadding,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // TODO
                onPressed: null,
                child: Text(
                  l10n.takePhoto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
