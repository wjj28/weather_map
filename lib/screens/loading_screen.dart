import 'package:flutter/material.dart';
import 'package:weather_map/screens/location_screen.dart';
import '../services/weather.dart';

// loading package
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // WeatherModel weatherModel = WeatherModel();

    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));

    print(weatherData);
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        backgroundColor: Colors.black54,
        body: Center(
            child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 50.0,
        ))
        // Container(
        //   color: Colors.lightBlueAccent,
        //   // margin: EdgeInsets.all(mDouble ?? 30),
        //   child: Center(
        //     child: ElevatedButton(
        //       onPressed: () {
        //         // Get the current location
        //         getLocationData();
        //       },
        //       child: const Text('Get Location..'),
        //     ),
        //   ),
        // ),
        );
  }
}
