import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/source/remote/trips_repository.dart';

abstract class TripsService {
  Future<List<Trip>> listTrips();

  Future<Trip> startTrip(String id);

  Future<Trip> endTrip(String id);
}

class TripsServiceImpl implements TripsService {
  final TripsRepository _repo;

  TripsServiceImpl(this._repo);

  @override
  Future<List<Trip>> listTrips() {
    return _repo.listTrips();
  }

  @override
  Future<Trip> startTrip(String id) {
    return _repo.startTrip(id);
  }

  @override
  Future<Trip> endTrip(String id) {
    return _repo.endTrip(id);
  }
}
