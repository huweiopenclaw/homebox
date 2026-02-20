class AppConstants {
  // App Info
  static const String appName = 'HomeBox';
  static const String appVersion = '1.0.0';
  static const String appDescription = '智能家庭收纳助手';
  
  // API
  static const String apiBaseUrl = 'http://localhost:8000/api/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String preferencesKey = 'user_preferences';
  static const String themeKey = 'theme_mode';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Image
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int imageQuality = 85;
  static const int thumbnailSize = 200;
  
  // AI Recognition
  static const double minConfidence = 0.7;
  static const int maxItemsPerRecognition = 50;
  
  // Cache
  static const Duration cacheDuration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // Animations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 1;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  
  // Room names (for quick selection)
  static const List<String> defaultRooms = [
    '客厅',
    '卧室',
    '厨房',
    '卫生间',
    '书房',
    '储藏室',
    '车库',
    '阳台',
    '儿童房',
    '阁楼',
  ];
  
  // Furniture names (for quick selection)
  static const Map<String, List<String>> defaultFurniture = {
    '客厅': ['沙发', '电视柜', '茶几', '书架', '展示柜'],
    '卧室': ['衣柜', '床', '床头柜', '梳妆台', '斗柜'],
    '厨房': ['橱柜', '冰箱', '储物柜', '料理台'],
    '书房': ['书桌', '书架', '文件柜', '抽屉'],
    '储藏室': ['架子', '收纳箱', '柜子'],
  };
  
  // Category names
  static const List<String> defaultCategories = [
    '衣物',
    '书籍',
    '电子产品',
    '文件',
    '工具',
    '玩具',
    '厨具',
    '装饰品',
    '运动用品',
    '药品',
    '食品',
    '其他',
  ];
}
