

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) =>WeatherCubit(WeatherService()),
      child:const WeatherApp()
    )
    );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: BlocProvider.of<WeatherCubit>(context).weathermodel==null?Colors.blue:
           BlocProvider.of<WeatherCubit>(context).weathermodel?.getThemeColor()
          ),
          primarySwatch:BlocProvider.of<WeatherCubit>(context).weathermodel==null?Colors.blue:
           BlocProvider.of<WeatherCubit>(context).weathermodel?.getThemeColor()
        ),
        home:  HomePage(),
      );
  }
}
