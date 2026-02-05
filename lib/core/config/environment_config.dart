

class EnvironmentConfig {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String login = '/auth/login';
  static const String products = '/products';
  static const String categories = '/products/categories';
  static String productById(int id) => '/products/$id';
  static String productsByCategory(String category) => '/products/category/$category';
  static const String carts = '/carts';
  static String cartsByUserId(int userId) => '/carts/user/$userId';
  static String userById(int userId) => '/users/$userId';
}
