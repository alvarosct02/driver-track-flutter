import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/data/source/remote/user_repository.dart';

abstract class UserService {
  Future<User> updateServiceAvailability(bool isAvailable);

  Future<User> updateAirportAvailability(bool isNear);

  Future updateUserLocation(double lat, double lon);

  Future<User> getUserInfo();
}

class UserServiceImpl implements UserService {
  final UserRepository _repo;

  UserServiceImpl(this._repo);

  @override
  Future<User> updateServiceAvailability(bool isAvailable) {
    return _repo.updateServiceAvailability(isAvailable);
  }

  @override
  Future<User> updateAirportAvailability(bool isNear) {
    return _repo.updateAirportAvailability(isNear);
  }

  @override
  Future updateUserLocation(double lat, double lon) {
    return _repo.updateUserLocation(lat, lon);
  }

  @override
  Future<User> getUserInfo() {
    return _repo.getUserInfo();
  }
}
