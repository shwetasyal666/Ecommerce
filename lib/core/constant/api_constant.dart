class ApiConstants {
  // Base URL - Replace with your actual API
  static const String baseUrl = 'https://api.yourdomain.com/v1';
  
  // Endpoints
  static const String products = '/products';
  static const String categories = '/categories';
  static const String orders = '/orders';
  static const String users = '/users';
  static const String cart = '/cart';
  static const String payment = '/payment';
  
  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}