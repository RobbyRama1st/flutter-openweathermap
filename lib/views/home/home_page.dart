import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/hourly.dart';
import 'package:weather_app_test/services/weather_service.dart';
import 'package:weather_app_test/utils/forecast_util.dart';
import 'dart:ui';
import 'package:weather_app_test/utils/hex-color-converter.dart';
import 'package:weather_app_test/views/detail/cubit/detail_cubit.dart';
import 'package:weather_app_test/views/detail/detail_page.dart';
import 'package:weather_app_test/views/home/cubit/home_cubit.dart';
import 'package:weather_app_test/widgets/loding_progress.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _homeCubit;
  var logger = Logger();
  
  late String dynamicTimeAgo = "";
  late String cityName = "";
  late String icon = "";
  late String temp = "";
  late String desc = "";
  late String wind = "";
  late String humidity = "";
  late String chanceOfRain = "";

  List<Hourly?> listHoursly = [];
  
  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
     onLoading(context);
    _homeCubit.getCurrentWeather();
    _homeCubit.getHourlyWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeLoadingState) {
            logger.i("onLoading");
           
          }
    
          if(state is HomeDisposeLoadingState) {
            logger.i("onDisposeLoading");
            Navigator.of(context, rootNavigator: false).pop();
          }
    
          if(state is HomeLoadCurrentFailedState) {
            logger.i("onFetchCurrentFailed");
          }
    
          if(state is HomeLoadCurrentSuccessState) {   
            logger.i("onFetchCurrentSuccess");
            setState(() {
               cityName = state.value.name.toString();
               icon = state.value.weather![0].main!;
               temp = state.value.main!.temp!.toStringAsFixed(0);
               desc = state.value.weather![0].description!;
               wind = state.value.wind!.speed.toString();
               humidity = state.value.main!.humidity.toString();
               chanceOfRain = state.value.clouds!.all.toString();
            });
          } 

          if(state is HomeLoadHourlyFailedState) {
            logger.i("onFetchHourlyFailed");
          }

          if(state is HomeLoadHourlySuccessState) {
            logger.i("onFetchHourlySuccess");
            setState(() {
              String time = timeAgoSinceDate(time: DateTime.now());
              dynamicTimeAgo = "Updated $time";
              listHoursly.addAll(state.value.hourly!.toList().skip(1).take(4).toList());
            });
          }
          
        } ,
        child: Column(
          children: [
            currentWeather(),
            todayWeather(),
          ],
        ),
      ),
    );
  }

  String timeAgoSinceDate({bool numericDates = true, required DateTime time}) {
  time.toLocal();
  final date2 = DateTime.now().toLocal();
  final difference = date2.difference(time);

  if (difference.inSeconds < 5) {
    return 'Just now';
  } else if (difference.inSeconds <= 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes <= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours <= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inHours <= 60) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays <= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inDays <= 6) {
    return '${difference.inDays} days ago';
  } else if ((difference.inDays / 7).ceil() <= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if ((difference.inDays / 7).ceil() <= 4) {
    return '${(difference.inDays / 7).ceil()} weeks ago';
  } else if ((difference.inDays / 30).ceil() <= 1) {
    return (numericDates) ? '1 month ago' : 'Last month';
  } else if ((difference.inDays / 30).ceil() <= 30) {
    return '${(difference.inDays / 30).ceil()} months ago';
  } else if ((difference.inDays / 365).ceil() <= 1) {
    return (numericDates) ? '1 year ago' : 'Last year';
  }
  return '${(difference.inDays / 365).floor()} years ago';
}

  todayDate(){
    DateTime now = DateTime.now();
    DateTime today = now.subtract(Duration(days: 0));
    DateTime localDateTime = today.toLocal();
    final locale = Localizations.localeOf(context);
    final localizations = MaterialLocalizations.of(context);

    if (localDateTime.day == today.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return "Today, " + today.day.toString() + " " + ForecastUtil.findMonth(today.month);
    }
  }

  Widget currentWeather() {
    return Container(
      height: MediaQuery.of(context).size.height - 230,
      padding: EdgeInsets.only(top: 35, left: 2, right: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColorConverter("#78D1F5"),
            HexColorConverter("#126CF4"),
              ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff00A1FF).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 9,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: (){
                  logger.i("Dashboard clicked!");
                }, 
                icon:  Image.asset(
                  'assets/icons/ic_dashboard.png',
                  width: 30,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/ic_location.png', width: 17,
                  ),
                  SizedBox(width: 5,),
                  Text(cityName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.white)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/dot_yellow.png", scale: 2,),
                  SizedBox(height: 20, width: 10,),
                  Text(dynamicTimeAgo , style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  top:-40,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(ForecastUtil.findIcon(icon),
                            color: Colors.black,  width: 270),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Image(
                                image: AssetImage(
                                  ForecastUtil.findIcon(icon),
                                ),
                                width: 270,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 70,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 48,),
                          Text(temp.toString(),
                          style: TextStyle(
                            height: 0.1,
                            fontSize: 130,
                            fontWeight: FontWeight.bold),
                          ),
                          Text("\u00B0",
                          style: TextStyle(
                            color: HexColorConverter("#82B5F8"),
                            height: 0.1,
                            fontSize: 130,),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(desc,
                            style: TextStyle(
                              fontSize: 25,),
                      ),
                      Text(todayDate(), 
                      style: TextStyle(
                        color: HexColorConverter("#82B5F8"),
                        fontSize: 12),
                      ),
                    ],    
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          extraWeather(),
        ],
      ),
    );
  }

  Widget extraWeather(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                    'assets/images/wind.png', width: 33,
                  ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            Text("$wind Km/h",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Wind",
              style: TextStyle(color: HexColorConverter("#69B5FF"), fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Image.asset(
                    'assets/images/humidity.png', width: 13,
            ),
            SizedBox(
              height: 10,
            ),
            Text("$humidity %",
              style: TextStyle( fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Humidity",
              style: TextStyle(color: HexColorConverter("#69B5FF"), fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Image.asset(
                    'assets/images/rain.png', width: 24,
            ),
            SizedBox(
              height: 10,
            ),
            Text("$chanceOfRain %",
              style: TextStyle( fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rain",
              style: TextStyle(color: HexColorConverter("#69B5FF"), fontSize: 16),
            )
          ],
        )
      ],
    );
  }

  Widget todayWeather(){
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                onTap: (){
                  logger.i("7 Days clicked!");
                  _homeCubit.pushToPage(
                    pageBuilder: BlocProvider(
                      create: (context) => DetailCubit(service: WeatherService()),
                      child: DetailPage(),
                    ), 
                    context: context
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      "7 Days ",
                      style: TextStyle(
                        fontSize: 18, color: Colors.grey
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: HexColorConverter("#272727"),),
                    borderRadius: BorderRadius.circular(35)),
                      child: itemCardHourly(listHoursly, index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: listHoursly.length,
            ),
          )
        ],
      ),
    );
  }

  Widget itemCardHourly(List<Hourly?> data, int index){
    var date = DateTime.fromMillisecondsSinceEpoch(data[index]!.dt! * 1000);
    final hours = DateFormat.Hm().format(date);
    return Column(  crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Text(data[index]!.temp!.toStringAsFixed(0) + " \u00B0",
           style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        Image(
          image: AssetImage(
             ForecastUtil.findIcon(data[index]!.weather![0]!.main!),
          ),
          width: 60,
        ),
        Text(hours,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
