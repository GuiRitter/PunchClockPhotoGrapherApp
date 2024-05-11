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

    if (list == null) {
      return Text(
        l10n.getNotCalled,
      );
    }

    if (list.data.isEmpty) {
      return Text(
        l10n.noPhoto,
      );
    }

    return Text(
      list.data,
    );
  }
}
