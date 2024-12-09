class ServicesPath {
  ServicesPath._();
  static final instance = ServicesPath._();
  final String baseUrl = "http://51.20.142.167:8080/";

  final String login = 'auth/login';
  final String register = 'auth/register';
  final String valideCode = 'auth/valide-code';
  final String refreshToken = 'auth/refresh-token';

  final String news = 'api/news';

  final String weather = 'api/weather';

  final String user = 'api/user';

  final String city = 'api/city';
  final String district = 'api/district/city/';
}
