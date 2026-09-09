import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get clientId => dotenv.get("CLIENT_ID");
  static String get secretClient => dotenv.get("SECRET_CLIENT");
  static String get apiUrl => "https://api.spotify.com/v1";
  static String get authUrl => "https://accounts.spotify.com/api";
}
