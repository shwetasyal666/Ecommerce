class HiveConstants {
  // Box Names
  static const String userBox = 'userBox';
  static const String cartBox = 'cartBox';
  static const String productsBox = 'productsBox';
  static const String settingsBox = 'settingsBox';
  static const String ordersBox = 'ordersBox';
  
  // Keys
  static const String currentUserKey = 'current_user';
  static const String cartKey = 'cart';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String cachedProductsKey = 'cached_products';
  static const String authTokenKey = 'auth_token';
  
  // Type IDs (must be unique)
  static const int userTypeId = 0;
  static const int productTypeId = 1;
  static const int cartTypeId = 2;
  static const int cartItemTypeId = 3;
  static const int orderTypeId = 4;
  static const int addressTypeId = 5;
  static const int categoryTypeId = 6;
}