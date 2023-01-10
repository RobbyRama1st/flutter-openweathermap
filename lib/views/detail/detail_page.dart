import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/daily.dart';
import 'package:weather_app_test/utils/forecast_util.dart';
import 'package:weather_app_test/utils/hex-color-converter.dart';
import 'package:weather_app_test/views/detail/cubit/detail_cubit.dart';
import 'package:weather_app_test/widgets/loding_progress.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  late DetailCubit _detailCubit;
  var logger = Logger();

  late String icon = "";
  late String tempMax = "";
  late String tempMin = "";
  late String desc = "";
  late String wind = "";
  late String humidity = "";
  late String chanceOfRain = "";

  Daily? tommorrow;
  List<Daily?> listDaily = [];

  late String iconForecast = "";
  late String descForecast = "";
  late String tempMaxForecast = "";
  late String tempMinForecast = "";
  
  @override
  void initState() {
    _detailCubit = BlocProvider.of<DetailCubit>(context);
    onLoading(context);
    _detailCubit.getSevenDaysWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: BlocListener<DetailCubit, DetailState>(
        listener: (context, state) {
          if(state is DetailLoadingState) {
            logger.i("onLoading");
          }

          if(state is DetailDisposeLoadingState) {
            logger.i("onDisposeLoading");
            Navigator.of(context, rootNavigator: false).pop();
          }

          if(state is DetailLoadSevenDaysFailedState) {
            logger.i("onFetchSevenDaysFailed");
          }

          if(state is DetailLoadSevenDaysSuccessState) {
            logger.i("onFetchSevenDaysSuccess");
            setState(() {
              listDaily.addAll(state.value.daily!.toList().skip(1).take(7).toList());
              
              icon = listDaily[0]!.weather![0]!.main.toString();
              tempMax = listDaily[0]!.temp!.max!.toStringAsFixed(0);
              tempMin = listDaily[0]!.temp!.min!.toStringAsFixed(0);
              desc = listDaily[0]!.weather![0]!.description.toString();
              wind = listDaily[0]!.windSpeed!.toString();
              humidity = listDaily[0]!.humidity!.toString();
              chanceOfRain = listDaily[0]!.clouds.toString();
            });
          }
        },
        child: Column(
          children: [
            tomorrowWeather(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return listSevenDays(listDaily, index);
                },
                itemCount: listDaily.length,
              )
            ),
          ]
        ),
      ),
    );
  }

  Widget tomorrowWeather(){
    return Container(
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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon:  Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                )
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/ic_calendar.png', width: 17,
                  ),
                  SizedBox(width: 5,),
                  Text( "7 Days",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.white)
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ForecastUtil.findIcon(icon),
                      ),
                    ),
                  ),        
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 18, height: 0.1),
                    ),
                    SizedBox(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(tempMax,
                            style: TextStyle(
                                fontSize: 80, fontWeight: FontWeight.bold),
                          ),
                          Text("/$tempMin \u00B0",
                            style: TextStyle(
                                color: HexColorConverter("#82B5F8"),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Text(desc,
                      style: TextStyle(
                        color: HexColorConverter("#82B5F8"),
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                extraWeather(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget extraWeather(){
    return Padding(
      padding:  EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                      'assets/images/wind.png', width: 33,
              ),
              SizedBox(
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
              Text(humidity,
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
      ),
    );
  }

  Widget listSevenDays(List<Daily?> data, int index){
    var dayOfWeek = '';
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(data[index]!.dt! * 1000);
    var fullDate = ForecastUtil.getFormattedDate(date);

    dayOfWeek = fullDate.split(',')[0]; 

    iconForecast = data[index]!.weather![0]!.main.toString();
    descForecast = data[index]!.weather![0]!.description.toString();
    tempMaxForecast = data[index]!.temp!.max!.toStringAsFixed(0);
    tempMinForecast = data[index]!.temp!.min!.toStringAsFixed(0);
    
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dayOfWeek, style: TextStyle(color: HexColorConverter("#68798F"), fontSize: 16),),
          SizedBox(
            width: 135,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(ForecastUtil.findIcon(iconForecast)),
                  width: 60,
                ),
                Text(descForecast,
                 style: TextStyle(color: HexColorConverter("#68798F"), fontSize: 16),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "+$tempMaxForecast \u00B0",  style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "+$tempMinForecast \u00B0", style: TextStyle(color: HexColorConverter("#68798F"), fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}