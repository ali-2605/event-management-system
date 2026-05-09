class RuntimeConfig {
  static const bool loaded = false;

  static const String apiHost = String.fromEnvironment(
    'API_HOST',
    defaultValue: 'localhost',
  );

  static const String apiPort = String.fromEnvironment(
    'API_PORT',
    defaultValue: '8080',
  );
}