import 'package:get_it/get_it.dart';
import './security_settings.dart';
import 'security_settings_impl.dart';

GetIt authLocator = GetIt.instance;

setupAuthLocator() {
  authLocator
      .registerLazySingleton<SecuritySettings>(() => SecuritySettingsImpl());
}
