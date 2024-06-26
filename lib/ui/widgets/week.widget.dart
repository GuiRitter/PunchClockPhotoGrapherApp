import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        ConnectionState,
        Divider,
        EdgeInsets,
        ElevatedButton,
        Expanded,
        FutureBuilder,
        GlobalKey,
        Icon,
        Icons,
        IntrinsicColumnWidth,
        Material,
        Padding,
        RenderBox,
        Row,
        SizedBox,
        StatelessWidget,
        Table,
        TableBorder,
        TableCell,
        TableCellVerticalAlignment,
        TableColumnWidth,
        TableRow,
        Text,
        TextAlign,
        Theme,
        Widget;
import 'package:intl/intl.dart' show DateFormat;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings;
import 'package:punch_clock_photo_grapher_app/models/date.model.dart'
    show DateModel;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show WeekModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show appBarElevation, tableRowHeight;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show buildIntrinsicColumnWidthMap, logger, MapExtension;

double? dataTableWidth;

late double halfFieldPadding;

final _keyMap = <int, GlobalKey>{};

final _log = logger('WeekWidget');

final _widthMap = <int, double>{};

Future<double> getDataTableWidth({
  required int weekNumber,
  required int delay,
}) async {
  _log('getDataTableWidth').raw('delay', delay).print();

  var width = _widthMap[weekNumber];

  if (width != null) {
    return width;
  }

  await Future.delayed(
    Duration(
      microseconds: delay,
    ),
  );

  final dataTableKey = _keyMap[weekNumber] as GlobalKey;

  final BuildContext? dataTableContext = dataTableKey.currentContext;

  if ((dataTableContext != null) && (dataTableContext.mounted)) {
    final renderBox = dataTableContext.findRenderObject() as RenderBox;

    width = renderBox.size.width;

    _widthMap[weekNumber] = width;

    return width;
  } else {
    return await getDataTableWidth(
      weekNumber: weekNumber,
      delay: delay + 1,
    );
  }
}

class WeekWidget extends StatelessWidget {
  final WeekModel week;

  const WeekWidget({
    super.key,
    required this.week,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;
    halfFieldPadding = fieldPadding / 2;

    toRow(
      DateModel date,
    ) =>
        buildRow(
          date: date,
          timeCountMax: week.timeCountMax,
        );

    final dataTableKey = _keyMap.getValueOrNew(
      key: week.number,
      generator: () => GlobalKey(),
    );

    final borderSide = Divider.createBorderSide(
      context,
    );

    final dataTable = Table(
      key: dataTableKey,
      border: TableBorder(
        top: borderSide,
        horizontalInside: borderSide,
      ),
      columnWidths: buildIntrinsicColumnWidthMap(
        count: (week.timeCountMax * 2) + 1,
      ),
      children: [
        ...week.dateList.map(
          toRow,
        ),
      ],
    );

    final padding = tableRowHeight! / 2;

    return FutureBuilder<double>(
      future: getDataTableWidth(
        weekNumber: week.number,
        delay: 0,
      ),
      builder: (
        context,
        tableWidthSnapshot,
      ) {
        if ((tableWidthSnapshot.connectionState == ConnectionState.done) &&
            tableWidthSnapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(
              padding,
            ),
            child: Material(
              elevation: appBarElevation!,
              child: Column(
                children: [
                  SizedBox(
                    width: tableWidthSnapshot.data!,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(
                              halfFieldPadding,
                            ),
                            child: Text(
                              textAlign: TextAlign.start,
                              week.header,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            halfFieldPadding,
                          ),
                          child: const ElevatedButton(
                            onPressed: null,
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  dataTable,
                ],
              ),
            ),
          );
        } else {
          return dataTable;
        }
      },
    );
  }

  Widget buildCell({
    required Widget child,
  }) =>
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.all(
            halfFieldPadding,
          ),
          child: child,
        ),
      );

  Widget buildEmptyDataCell(
    _,
  ) =>
      buildCell(
        child: const SizedBox.shrink(),
      );

  TableColumnWidth buildEmptyDataColumn(
    _,
  ) =>
      const IntrinsicColumnWidth();

  TableRow buildRow({
    required DateModel date,
    required int timeCountMax,
  }) {
    final timeCountToFill = (timeCountMax - date.timeCount) * 2;

    return TableRow(
      children: [
        buildCell(
          child: Text(
            date.weekDay,
          ),
        ),
        ...date.timeList.expand(
          toCellPair,
        ),
        if (timeCountToFill > 0)
          ...List.generate(
            timeCountToFill,
            buildEmptyDataCell,
          )
      ],
    );
  }

  List<Widget> toCellPair(
    String dateTimeStamp,
  ) {
    final dateTime = DateTime.parse(
      dateTimeStamp,
    ).toLocal();

    return [
      buildCell(
        child: Text(
          DateFormat.Hm(
            Settings.locale,
          ).format(
            dateTime,
          ),
        ),
      ),
      buildCell(
        child: const ElevatedButton(
          // TODO
          onPressed: null,
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
    ];
  }
}
