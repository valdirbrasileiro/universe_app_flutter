import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'commons.dart';

Future<void> runNasaApp() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    await GetStorage.init();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    if (!kIsWeb) {
      FlutterError.onError = onFlutterError;
    }

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(
      const DefaultApp(),
    );
  }, (Object error, StackTrace stack) {
    while (error is Exception && error is http.ClientException) {
      error = error;
    }
    if (error is! http.ClientException) {
      navigateToNamed('/generic_error');
    }
  });
}
