import 'package:driver_track/data/source/local/session_repository.dart';
import 'package:driver_track/data/source/remote/auth_repository.dart';
import 'package:driver_track/data/source/remote/user_repository.dart';
import 'package:driver_track/data/source/services/trips_service.dart';
import 'package:driver_track/data/source/services/user_service.dart';

import 'data/source/remote/trips_repository.dart';
import 'data/source/services/auth_service.dart';

class Injector {
  static Injector _instance;

  static Injector get instance {
    if (_instance == null) {
      _instance = Injector._privateConstructor();
    }
    return _instance;
  }

  AuthService authService;
  TripsService tripsService;
  UserService userService;

  Injector._privateConstructor() {
    var baseUrl = "http://d1f4ef57fea3.ngrok.io/api/v1";
    var baseUrlApiary = baseUrl;
    // var baseUrlApiary = "https://private-c95e1f-drivertrack.apiary-mock.com";
    var prefs = SessionRepository();

    var authRepo = AuthRepositoryImpl(baseUrlApiary);
    var tripsRepo = TripsRepositoryImpl(baseUrlApiary);
    var userRepo = UserRepositoryImpl(baseUrlApiary);

    authService = AuthServiceImpl(authRepo, prefs);
    tripsService = TripsServiceImpl(tripsRepo);
    userService = UserServiceImpl(userRepo);
  }

  Future<String> getUserToken() async {
    var user = await authService.getLoggedUser();
    return user.token;
  }
}
