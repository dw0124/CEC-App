extension DatetimeExtensions on DateTime {
  String timeAgo() {
    final now = DateTime.now().toLocal();
    final difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '$year.${month.toString().padLeft(2, '0')}.${day.toString().padLeft(2, '0')}';
    }
  }

  String toFormatted() {
    twoDigits(int n) => n.toString().padLeft(2, '0');

    return '$year.${twoDigits(month)}.${twoDigits(day)} ${twoDigits(hour)}:${twoDigits(minute)}';
  }
}