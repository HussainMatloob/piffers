import 'package:get/get.dart';

class WeatherController extends GetxController {
  // Static data for now (replace with API calls later)
  var temperature = 19.obs;
  var city = "Islamabad".obs;
  var date = "Tue, 21 Jan".obs;

  // Weather stats
  var windSpeed = "15 km".obs;
  var humidity = "34%".obs;
  var perception = "90%".obs;

  // Hourly forecast data
  var hourlyForecast = [
    {"time": "01:00", "temp": "19°", "icon": "cloudy"},
    {"time": "02:00", "temp": "21°", "icon": "sunny"},
    {"time": "03:00", "temp": "22°", "icon": "sunny"},
    {"time": "04:00", "temp": "21°", "icon": "sunny"},
    {"time": "05:00", "temp": "20°", "icon": "cloudy"},
  ].obs;

  // Other cities' weather
  var otherCities = [
    {"city": "Lahore", "temp": "22°", "condition": "Partly Cloudy"},
    {"city": "Karachi", "temp": "25°", "condition": "Sunny"},
  ].obs;

  // Function to refresh/fetch data (replace with actual API call)
  void fetchWeather() {
    // Example: Update values (replace with dynamic data)
    temperature.value = 20; // Example: New temperature
    city.value = "Lahore";  // Example: Change city
    date.value = "Wed, 22 Jan";
  }
}
