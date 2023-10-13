import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName});

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    return WeatherModel(
        date: DateTime.parse( data['current']['last_updated']),
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text']);
  }

  @override
  String toString() {
    return 'tem = $temp  minTemp = $minTemp  date = $date';
  }

   String getImage() {
    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear' ||  weatherStateName == 'partly cloudy') {
      return 'assets/images/clear.png';
    } else if (
        
        weatherStateName == 'Blizzard' ||  weatherStateName == 'Patchy snow possible'  ||  weatherStateName == 'Patchy sleet possible' || weatherStateName == 'Patchy freezing drizzle possible' || weatherStateName == 'Blowing snow') {
      return 'assets/images/snow.png';
    } else if (weatherStateName == 'Freezing fog' || weatherStateName == 'Fog' ||  weatherStateName == 'Heavy Cloud' || weatherStateName == 'Mist' || weatherStateName == 'Fog') {
      return 'assets/images/cloudy.png';
    } else if (weatherStateName == 'Patchy rain possible' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers	') {
      return 'assets/images/rainy.png';
    } else if (weatherStateName == 'Thundery outbreaks possible' || weatherStateName == 'Moderate or heavy snow with thunder' || weatherStateName == 'Patchy light snow with thunder'|| weatherStateName == 'Moderate or heavy rain with thunder' || weatherStateName == 'Patchy light rain with thunder' ) {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }
MaterialColor getThemeColor() {
   switch(weatherStateName){
    case 'Blizzard':
    case 'Patchy snow possible' :
    case 'Patchy sleet possible' :
    case 'Patchy freezing drizzle possible' :
    case 'Blowing snow' :
    case 'Patchy rain possible':
    case 'Heavy Rain':
    case 'Showers':
            return Colors.blue;
   case 'Freezing fog':
    case 'Fog' :
    case 'Heavy Cloud' :
    case 'Mist':
    case 'Fog':
        return Colors.blueGrey;
   case  'Thundery outbreaks possible' :
   case 'Moderate or heavy snow with thunder': 
   case 'Patchy light snow with thunder':
   case 'Moderate or heavy rain with thunder': 
   case 'Patchy light rain with thunder':
        return Colors.deepPurple;
  default:
       return Colors.orange;
   }
    // if (weatherStateName == 'Sunny' || weatherStateName == 'Clear' ||  weatherStateName == 'partly cloudy') {
    //   return Colors.orange;
    // } else if (
        
    //     weatherStateName == 'Blizzard' ||  weatherStateName == 'Patchy snow possible'  ||  weatherStateName == 'Patchy sleet possible' || weatherStateName == 'Patchy freezing drizzle possible' || weatherStateName == 'Blowing snow') {
    //   return Colors.blue;
    // } else if (weatherStateName == 'Freezing fog' || weatherStateName == 'Fog' ||  weatherStateName == 'Heavy Cloud' || weatherStateName == 'Mist' || weatherStateName == 'Fog') {
    //   return Colors.blueGrey;
    // } else if (weatherStateName == 'Patchy rain possible' ||
    //     weatherStateName == 'Heavy Rain' ||
    //     weatherStateName == 'Showers	') {
    //   return Colors.blue;
    // } else if (weatherStateName == 'Thundery outbreaks possible' || weatherStateName == 'Moderate or heavy snow with thunder' || weatherStateName == 'Patchy light snow with thunder'|| weatherStateName == 'Moderate or heavy rain with thunder' || weatherStateName == 'Patchy light rain with thunder' ) {
    //   return Colors.deepPurple;
    // } else {
    //   return Colors.orange;
    // }
  }


}
