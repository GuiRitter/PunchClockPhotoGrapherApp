Map<String, dynamic> toLog(
  LoggableModel item,
) =>
    item.asLog();

abstract class LoggableModel {
  Map<String, dynamic> asLog();
}

extension LoggableSetExtension on Set<LoggableModel> {
  List<Map<String, dynamic>> asLog() => toList()
      .map(
        toLog,
      )
      .toList();
}
