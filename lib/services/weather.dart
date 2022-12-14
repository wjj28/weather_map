import '../services/location.dart';
import '../services/networking.dart';


const openWeatherMap = "https://api.openweathermap.org/data/2.5/weather?";
const celsius = "units=metric";

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '${openWeatherMap}q=${cityName}&appid=${apiKey}&${celsius}';

    NetworkHelper networkHelper = NetworkHelper(url);

    var cityData = await networkHelper.getData();
    return cityData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    try {
      await location.getCurrentLocation();

      var request =
          '${openWeatherMap}lat=${location.latitude}&lon=${location.longitude}&${celsius}&appid=${apiKey}';

      NetworkHelper networkHelper = NetworkHelper(request);

      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
