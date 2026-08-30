class AppConfig {
  const AppConfig({required this.supabaseUrl, required this.publishableKey});

  const AppConfig.fromEnvironment()
    : supabaseUrl = const String.fromEnvironment('SUPABASE_URL'),
      publishableKey = const String.fromEnvironment(
        'SUPABASE_PUBLISHABLE_KEY',
        defaultValue: String.fromEnvironment('SUPABASE_ANON_KEY'),
      );

  final String supabaseUrl;
  final String publishableKey;

  bool get isConfigured {
    final uri = Uri.tryParse(supabaseUrl);
    return publishableKey.isNotEmpty &&
        uri != null &&
        uri.hasScheme &&
        uri.host.isNotEmpty;
  }
}
