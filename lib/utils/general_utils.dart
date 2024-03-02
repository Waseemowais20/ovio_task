import '../general_exports.dart';

String getWeatherDescription(double temperature, bool isCelsius) {
  double convertedTemperature =
      isCelsius ? temperature : (temperature - 32) * 5 / 9;

  if (convertedTemperature < 0) {
    return AppStrings.extremelyCold;
  } else if (convertedTemperature < 10) {
    return AppStrings.veryCold;
  } else if (convertedTemperature < 20) {
    return AppStrings.cool;
  } else if (convertedTemperature < 30) {
    return AppStrings.moderate;
  } else if (convertedTemperature < 35) {
    return AppStrings.warm;
  } else {
    return AppStrings.hot;
  }
}

String getCurrentTimeInAmman({int? addedDays}) {
  // Get the current time
  DateTime currentTime = DateTime.now().toUtc();

  // Convert the time to the timezone of Amman (UTC+3:00)
  currentTime = currentTime.add(Duration(hours: 2));

  // Format the time in the desired format
  String formattedTime =
      "${currentTime.year.toString().padLeft(4, '0')}-${currentTime.month.toString().padLeft(2, '0')}-${currentTime.day.toString().padLeft(2, '0')}T${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}.000+03:00";

  return formattedTime;
}

String getDateInUTC({int addedDays = 0}) {
  // Get the current time
  DateTime currentTime = DateTime.now().toUtc();

  // Add the specified number of days
  currentTime = currentTime.add(Duration(days: addedDays));

  currentTime = DateTime.utc(
      currentTime.year, currentTime.month, currentTime.day, 0, 0, 0);

  // Format the time in the desired format
  String formattedTime =
      "${currentTime.year.toString().padLeft(4, '0')}-${currentTime.month.toString().padLeft(2, '0')}-${currentTime.day.toString().padLeft(2, '0')}T12:00:00.000Z";

  return formattedTime;
}
