import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        ConnectionState,
        ElevatedButton,
        Expanded,
        FutureBuilder,
        GlobalKey,
        RenderBox,
        SingleChildScrollView,
        StatelessWidget,
        Table,
        TableCell,
        TableRow,
        Text,
        Theme,
        Widget;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show l10n;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show ListModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show getAppBarElevation, WeekWidget;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

double? tableRowHeight;

final _log = logger('HomeWidget');

final _tableKey = GlobalKey();

Future<double> getRowWithElevatedButtonHeight({
  required int delay,
}) async {
  _log('getRowWithElevatedButtonHeight').raw('delay', delay).print();

  var height = tableRowHeight;

  if (height != null) {
    return height;
  }

  await Future.delayed(
    Duration(
      microseconds: delay,
    ),
  );

  final BuildContext? dataTableContext = _tableKey.currentContext;

  if ((dataTableContext != null) && (dataTableContext.mounted)) {
    final renderBox = dataTableContext.findRenderObject() as RenderBox;

    height = renderBox.size.height;

    tableRowHeight = height;

    return height;
  } else {
    return await getRowWithElevatedButtonHeight(
      delay: delay + 1,
    );
  }
}

class HomeWidget extends StatelessWidget {
  final ListModel? model;

  const HomeWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    return Expanded(
      child: Center(
        child: getBody(
          model: model,
          padding: fieldPadding,
        ),
      ),
    );
  }

  getBody({
    required ListModel? model,
    required double padding,
  }) {
    if (model == null) {
      return Text(
        l10n.getNotCalled,
      );
    } else if (model.weekList.isEmpty) {
      return Text(
        l10n.noPhoto,
      );
    } else {
      return FutureBuilder<double>(
        future: getAppBarElevation(
          delay: 0,
        ),
        builder: (
          context,
          elevationSnapshot,
        ) {
          if ((elevationSnapshot.connectionState == ConnectionState.done) &&
              (elevationSnapshot.hasData)) {
            return FutureBuilder<double>(
              future: getRowWithElevatedButtonHeight(
                delay: 0,
              ),
              builder: (
                context,
                rowHeightSnapshot,
              ) {
                if ((rowHeightSnapshot.connectionState ==
                        ConnectionState.done) &&
                    rowHeightSnapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Column(
                        children: getList(
                          model: model,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Table(
                    key: _tableKey,
                    children: const [
                      TableRow(
                        children: [
                          TableCell(
                            child: ElevatedButton(
                              onPressed: null,
                              child: Text(
                                '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    }
  }

  List<WeekWidget> getList({
    required ListModel? model,
  }) {
    if ((model == null) || model.weekList.isEmpty) {
      return List<WeekWidget>.empty();
    }

    var weekList = model.weekList.toList()..sort();

    return weekList
        .map(
          getWeekWidget,
        )
        .toList();
  }

  WeekWidget getWeekWidget(
    week,
  ) =>
      WeekWidget(
        week: week,
      );
}
