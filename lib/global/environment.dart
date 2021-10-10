import 'dart:io';

class Environment {

  /// URL base de APIs
  static String apiUrl    = Platform.isAndroid ? 'http://192.168.1.6:3000/api' : 'http://localhost:3000/api';
  
  /// URL base de Socket
  static String socketUrl = Platform.isAndroid ? 'http://192.168.1.6:3000/' : 'http://localhost:3000';
}
