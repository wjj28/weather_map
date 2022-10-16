import 'dart:ui';

import 'package:flutter/material.dart';
import '../utilities/constant.dart';
import 'city_screen.dart';
import 'loading_screen.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late String areaName;
  late int feelsLike;
  late int weatherCondition;
  late String weatherIcon;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        areaName = 'your location';
        feelsLike = 0;
        weatherCondition = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        return;
      }

      areaName = weatherData['name'];
      feelsLike = weatherData['main']['feels_like'].toInt();
      weatherCondition = weatherData["weather"][0]["id"];
      weatherIcon = weather.getWeatherIcon(weatherCondition);
      weatherMessage = weather.getMessage(feelsLike);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherDataObject =
                          await weather.getLocationWeather();
                      updateUI(weatherDataObject);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      // print(typedCity);
                      if (typedCity != null) {
                        var weatherData =
                            await weather.getCityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$feelsLike',
                                style: kTempTextStyle,
                              ),
                              const TextSpan(
                                text: "°",
                                style: TextStyle(
                                  fontSize: 80,
                                ),
                              ),
                               TextSpan(
                                text: '$weatherIcon',
                                style: kConditionTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherMessage} in ${areaName}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
