import 'package:get_it/get_it.dart';

import 'shared_preferences_service.dart';

GetIt storageLocator = GetIt.instance;

Future<void> setupStorageLocator() async {
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  storageLocator
      .registerSingleton<SharedPreferencesService>(sharedPreferencesService);
}
