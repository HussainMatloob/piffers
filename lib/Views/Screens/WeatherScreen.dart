import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Widgets/city_weather.dart';
import 'package:piffers/Views/Widgets/weather_stat.dart';
import '../Widgets/hourly_forecast.dart';
import '../controllers/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Today',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Weather details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${weatherController.temperature.value}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        weatherController.city.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        weatherController.date.value,
                        style:const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Weather stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherStat(
                    icon: Icons.air,
                    value: weatherController.windSpeed.value,
                    label: 'Wind Now',
                  ),
                  WeatherStat(
                    icon: Icons.water_drop_outlined,
                    value: weatherController.humidity.value,
                    label: 'Humidity',
                  ),
                  WeatherStat(
                    icon: Icons.remove_red_eye_outlined,
                    value: weatherController.perception.value,
                    label: 'Perception',
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Hourly Forecast
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: weatherController.hourlyForecast.map((forecast) {
                        return HourlyForecast(
                          time: forecast['time']!,
                          temp: forecast['temp']!,
                          icon: forecast['icon']! == "sunny"
                              ? Icons.wb_sunny
                              : Icons.cloud,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Other Cities
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Text(
                    'Other Cities',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weatherController.otherCities.map((cityWeather) {
                      return CityWeather(
                        city: cityWeather['city']!,
                        temp: cityWeather['temp']!,
                        condition: cityWeather['condition']!,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}