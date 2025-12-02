class AppConstants {
  // App Info
  static const String appName = 'E-Commerce App';
  static const String appVersion = '1.0.0';
  
  // Pagination
  static const int itemsPerPage = 20;
  static const int maxCacheSize = 100;
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);
  static const Duration shortCacheDuration = Duration(hours: 1);
}