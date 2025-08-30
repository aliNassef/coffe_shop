import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'SENTRY_DSN')
  static final String sentryDsn = _Env.sentryDsn;
  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY')
  static final String mapsApiKey = _Env.mapsApiKey;
  @EnviedField(varName: 'FIREBASE_ID')
  static final String firebaseId = _Env.firebaseId;
  @EnviedField(varName: 'FIREBASE_TOKEN')
  static final String firebaseToken = _Env.firebaseToken;
}
