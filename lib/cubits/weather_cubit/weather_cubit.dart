

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState>{
   WeatherService weatherservices;
  WeatherCubit(this.weatherservices):super(WeatherInitial());
  WeatherModel? weathermodel;
  String?cityname;
  getWeather(String cityName)async{
    emit(WeatherLoading());
    try {
     weathermodel=await  weatherservices.getWeather(cityName: cityName);
     cityname=cityName;
   emit(WeatherSuccess());
    } on Exception catch (e) {
      emit(WeatherFailure());
    }
  }
   
}