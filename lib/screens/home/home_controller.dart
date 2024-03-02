import 'package:location/location.dart';
import 'package:ovio_task/api/api_request.dart';
import 'package:ovio_task/api/models/weather_details.dart';
import 'package:ovio_task/general_exports.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:permission_handler/permission_handler.dart' as ph;

class HomeController extends GetxController {
  final Location _location = Location();
  Rx<LocationData?> locationData = Rx<LocationData?>(null);
  String? locationName = '';
  String selectedTemperature = 'C';
  WeatherDetailsModel? weatherDetailsModel;
  WeatherDetailsModel? weatherWeeklyDetailsModel;
  bool isLoading = true;
  List<geocoding.Placemark>? placeMarks;
  List<Coordinate>? cordinates = [];
  List<Date> dates = [];

  @override
  void onInit() {
    super.onInit();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permission;

    // Continuously request location permission until it is granted
    while (true) {
      serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permission = await _location.hasPermission();
      if (permission == PermissionStatus.granted) {
        break;
      }

      // Request permission to access location
      permission = await _location.requestPermission();
      if (permission == PermissionStatus.denied) {
        await _openLocationSettings();
      } else if (permission == PermissionStatus.deniedForever) {
        await _openLocationSettings();
        return;
      }
    }

    try {
      final LocationData currentLocation =
          await _location.getLocation().whenComplete(() {
        getWeatherDetails();
      });
      locationData.value = currentLocation;

      // Get the location name using reverse geocoding
      placeMarks = await geocoding.placemarkFromCoordinates(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
    } catch (e) {}
  }

  void changeTemperature(String temperature) {
    selectedTemperature = temperature;
    getWeatherDetails();
    update();
  }

  Future<void> _openLocationSettings() async {
    await ph.openAppSettings();
  }

  Future<void> getWeatherDetails() async {
    startLoading();
    isLoading = true;
    update();
    var token = await SecureStorageService().read(key: 'auth_token');
    var headers = {'Authorization': 'Bearer $token'};

    ApiRequest(
      path:
          '${getCurrentTimeInAmman()}/t_2m:$selectedTemperature/${locationData.value?.latitude ?? 0},${locationData.value?.longitude ?? 0}/json?model=mix',
      className: 'getWeatherDetails/HomeController',
      header: headers,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        weatherDetailsModel = WeatherDetailsModel.fromJson(response);
        cordinates = weatherDetailsModel?.data?[0].coordinates;

        getWeatherForTheRestOfTheWeek();
      },
      onError: (error) {
        isLoading = false;
      },
    );
  }

  getWeatherForTheRestOfTheWeek() async {
    var token = await SecureStorageService().read(key: 'auth_token');
    var headers = {'Authorization': 'Bearer $token'};

    ApiRequest(
      path:
          '${getDateInUTC(addedDays: 1)}--${getDateInUTC(addedDays: 8)}:P1D/t_2m:$selectedTemperature/${locationData.value?.latitude ?? 0},${locationData.value?.longitude ?? 0}/json?model=mix',
      className: 'getWeatherForTheRestOfTheWeek/HomeController',
      header: headers,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        weatherWeeklyDetailsModel = WeatherDetailsModel.fromJson(response);
        dates =
            weatherWeeklyDetailsModel?.data?.first.coordinates?.first.dates ??
                [];

        isLoading = false;
        update();
        dismissLoading();
      },
      onError: (error) {
        isLoading = false;
      },
    );
  }
}
