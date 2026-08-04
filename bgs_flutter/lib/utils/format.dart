const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// Turns a camelCase enum name (e.g. `flagFootball`) into a display label
/// (e.g. `Flag Football`).
String formatEnumLabel(String name) {
  final withSpaces = name.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (m) => '${m[1]} ${m[2]}',
  );
  return withSpaces[0].toUpperCase() + withSpaces.substring(1);
}

/// Formats a [DateTime] (converted to local time) as e.g. `Aug 4, 2026, 6:30 PM`.
String formatDateTime(DateTime dateTime) {
  final local = dateTime.toLocal();
  final hour24 = local.hour;
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final period = hour24 < 12 ? 'AM' : 'PM';
  final minute = local.minute.toString().padLeft(2, '0');
  return '${_monthNames[local.month - 1]} ${local.day}, ${local.year}, '
      '$hour12:$minute $period';
}
