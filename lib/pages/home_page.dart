import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';



// ignore: must_be_immutable
class HomePage extends StatelessWidget{

  WeatherModel? weatherData;

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final w=MediaQuery.of(context).size.width;
    final h=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon:const Icon(Icons.search),
          ),
        ],
         backgroundColor: BlocProvider.of<WeatherCubit>(context).weathermodel==null?Colors.blue:
         BlocProvider.of<WeatherCubit>(context).weathermodel?.getThemeColor(),
        title:const Text('Weather App'),
        centerTitle: true,
      ),
      body:BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if(state is WeatherLoading){
            return const CircularProgressIndicator();
          }
          else if(state is WeatherFailure ){
            return Failurebody(w: w, h: h);
          }
          else if(state is WeatherSuccess){
            weatherData=BlocProvider.of<WeatherCubit>(context).weathermodel;
            return Successbody(weatherData: weatherData);
          }
          else {
            return Initialbody(w: w, h: h);
          }
         
        },
      ) );
  }
}

class Initialbody extends StatelessWidget {
  const Initialbody({
    super.key,
    required this.w,
    required this.h,
  });

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
          Padding(
            
            padding:  EdgeInsets.symmetric(horizontal:w*0.1),
            child:  Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: h*0.03,
              ),
            ),
          ),
          Text(
            'searching now 🔍',
            style: TextStyle(
              fontSize: h*0.03,
            ),
          )
        ],
      ),
    );
  }
}

class Failurebody extends StatelessWidget {
  const Failurebody({
    super.key,
    required this.w,
    required this.h,
  });

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        
        padding:  EdgeInsets.symmetric(horizontal:w*0.1),
        child:  Text(
          'There is someThing Error please try now',
          style: TextStyle(
            fontSize: h*0.03,
          ),
        ),
      ),
    );
  }
}

class Successbody extends StatelessWidget {
  const Successbody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
           // Provider.of<WeatherProvider>(context).cityName!,
          "${ BlocProvider.of<WeatherCubit>(context).cityname}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style:const TextStyle(
              fontSize: 22,
            ),
          ),
         const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                weatherData!.temp.toInt().toString(),
                style:const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
         const Spacer(),
          Text(
            weatherData!.weatherStateName,
            style:const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
         const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
