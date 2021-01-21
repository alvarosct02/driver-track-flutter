import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/data/source/local/session_repository.dart';
import 'package:driver_track/data/source/remote/auth_repository.dart';

abstract class AuthService {
  void markOnBoardingComplete();

  Future<bool> isOnBoardingCompleted();

  Future<User> login(String username, String password);

  Future updateFcm(String fcmToken);

  Future<User> getLoggedUser();

  void saveLoggedUser(User user);

  void logout();
}

class AuthServiceImpl implements AuthService {
  final AuthRepository _authRepo;
  final SessionRepository _prefs;

  AuthServiceImpl(this._authRepo, this._prefs);

  @override
  void markOnBoardingComplete() {
    _prefs.saveOnBoardingCompleted();
  }

  @override
  Future<bool> isOnBoardingCompleted() {
    return _prefs.isOnBoardingCompleted();
  }

  @override
  Future<User> login(String username, String password) {
    return _authRepo.login(username, password);
  }

  @override
  Future updateFcm(String fcmToken) {
    // return _authRepo.updateFcmToken(fcmToken);
    return Future.delayed(Duration(milliseconds: 600));
  }

  @override
  Future<User> getLoggedUser() {
    return _prefs.getUser();
  }

  void saveLoggedUser(User user) {
    return _prefs.saveUser(user);
  }

  void logout() {
    _prefs.logout();
  }
}
