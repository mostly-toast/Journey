import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class AppSettings {
  AppSettings({
    required this.themeMode,
    required this.hasPin,
  });

  final AppThemeMode themeMode;
  final bool hasPin;

  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? hasPin,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      hasPin: hasPin ?? this.hasPin,
    );
  }
}

class AppSettingsStore {
  static const _keyTheme = 'settings.themeMode';
  static const _keyPin = 'settings.pin';

  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_keyTheme) ?? AppThemeMode.system.index;
    final mode = AppThemeMode.values[themeIndex];
    final hasPin = prefs.getString(_keyPin)?.isNotEmpty == true;
    return AppSettings(themeMode: mode, hasPin: hasPin);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTheme, mode.index);
  }

  Future<void> setPin(String? pin) async {
    final prefs = await SharedPreferences.getInstance();
    if (pin == null || pin.isEmpty) {
      await prefs.remove(_keyPin);
    } else {
      await prefs.setString(_keyPin, pin);
    }
  }

  Future<bool> verifyPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_keyPin);
    return stored != null && stored == pin;
  }
}

