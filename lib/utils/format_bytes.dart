String formatBytes(int bytes) {
  if (bytes < 1024) {
    return "$bytes B";
  } else if (bytes < 1024 * 1024) {
    final kib = (bytes / 1024).toStringAsFixed(2);
    return "$kib KiB";
  } else if (bytes < 1024 * 1024 * 1024) {
    final mib = (bytes / (1024 * 1024)).toStringAsFixed(2);
    return "$mib MiB";
  } else {
    final gib = (bytes / (1024 * 1024 * 1024)).toStringAsFixed(2);
    return "$gib GiB";
  }
}
