import 'package:flutter/material.dart';
import 'package:mausam/dataService.dart';
import 'package:weather/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = 'delhi';
  String temperature = '';
  double humidity = 0.0;
  String date = '';
  double rain = 0.0;
  double windSpeed = 0;
  String formattedDate = '';
  DateTime? dateTime;

  String weather = '';
  String key = '30660ec68faab5811e2250670da6b70f';
  String isDay(int checkTime) {
    int hour = checkTime;
    if (hour < 12 && hour > 5) {
      return 'Morning';
    }
    if ((hour > 19 && hour < 24) || (hour < 6 && hour >= 0)) {
      return 'Night';
    }
    return 'Evening';
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {
    WeatherFactory wf = WeatherFactory(key);
    Weather w = await wf.currentWeatherByCityName(cityName);
    setState(() {
      cityName = w.areaName!;
      humidity = w.humidity!;
      dateTime = w.date;
      rain = w.cloudiness!;
      windSpeed = w.windSpeed!;
      temperature = w.temperature!.celsius!.toStringAsFixed(0);
      date = w.date!.toString();
      formattedDate = DateFormat('HH:mm-EEEE,d MMMM y').format(dateTime!);
    });
    print(temperature);
    print(date);
    print(humidity);
    print(formattedDate);
    print(dateTime!.hour);
    print(w.cloudiness);
    print(isDay(dateTime!.hour));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/menu.svg',
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.9), BlendMode.dstATop),
          image: AssetImage(
            'assets/night.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: 250,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature + '°C',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Row(children: [
                  SvgPicture.asset(
                    'assets/moon.svg',
                    height: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    isDay(dateTime!.hour),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
                SizedBox(height: 20),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Wind',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        Text(windSpeed.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text('Km/h',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text('----',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Rain',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        Text(rain.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text("%",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text('----',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Humid',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        Text(humidity.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text("%",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Text('----',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//  Text(cityName),
// Text(temperature.toString()),
// Text(humidity.toString()),
