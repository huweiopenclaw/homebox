import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class Throttler {
  final Duration duration;
  DateTime? _lastExecution;

  Throttler({required this.duration});

  void call(void Function() action) {
    final now = DateTime.now();
    if (_lastExecution == null ||
        now.difference(_lastExecution!) >= duration) {
      _lastExecution = now;
      action();
    }
  }
}

class Validators {
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? '此字段'}不能为空';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 6) {
      return '密码至少6位';
    }
    if (value.length > 128) {
      return '密码最长128位';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value != password) {
      return '两次密码不一致';
    }
    return null;
  }

  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;
    if (value.length < min) {
      return '${fieldName ?? '此字段'}至少$min个字符';
    }
    return null;
  }

  static String? maxLength(String? value, int max, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;
    if (value.length > max) {
      return '${fieldName ?? '此字段'}最多$max个字符';
    }
    return null;
  }
}

class Formatters {
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  static String formatItemCount(int count) {
    return '$count 件';
  }

  static String formatBoxCount(int count) {
    return '$count 个箱子';
  }
}

class FileUtils {
  static String getExtension(String filename) {
    final parts = filename.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  static String getFilename(String path) {
    return path.split('/').last.split(r'\').last;
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}

class StringUtils {
  static bool isBlank(String? s) {
    return s == null || s.trim().isEmpty;
  }

  static bool isNotBlank(String? s) {
    return !isBlank(s);
  }

  static String truncate(String s, int maxLength, [String ellipsis = '...']) {
    if (s.length <= maxLength) return s;
    return s.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static String? nullIfEmpty(String? s) {
    if (s == null || s.isEmpty) return null;
    return s;
  }
}
