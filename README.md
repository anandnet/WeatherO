<img src="assets/icons/name1.png" width="250" >

# WeatherO

<img src="https://camo.githubusercontent.com/ca053d535977b87e502606c8652e9fb82dd9916f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4672616d65776f726b2d466c75747465722d3363633666643f6c6f676f3d666c7574746572" alt="Flutter" data-canonical-src="https://img.shields.io/badge/Framework-Flutter-3cc6fd?logo=flutter" style="max-width:100%;">  <img src="https://camo.githubusercontent.com/490738a70d715335e1848ff74041d7782fcec6dd/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c616e67756167652d446172742d3063343538623f6c6f676f3d64617274" alt="Dart" data-canonical-src="https://img.shields.io/badge/Language-Dart-0c458b?logo=dart" style="max-width:100%;">

    App to view Weather forcast.


![1](demo/demo2.gif)


#### Technology:
  * Flutter 1.22.1
 
#### Packages Used:
 * http
 * provider
 * sqflite
 * location
 * shared_preferences
 
 #### State Management:
  * Provider
 
 #### Icons:

       Created by myself found [here](https://www.figma.com/file/sFsu5UFcTulbk0Fzf8CtJH/Weather-3d-icon)

#### Api Used:
 * [OneWeathermap  Api](https://openweathermap.org/api) for weather
 * [Binglocation Api](https://docs.microsoft.com/en-us/bingmaps/rest-services/locations/find-a-location-by-query) for place search and details
 
#### Build Your own:
   * [Install flutter](https://flutter.dev/docs/get-started/install) in case if you don't have
   * Open the terminal or cmd Clone this repository: `git clone https://github.com/anandnet/WeatherO.git`
   * go to dir WeatherO `cd WeatherO`
   * paste the keys of [OneWeathermap  Api](https://openweathermap.org/api) and [Binglocation Api](https://docs.microsoft.com/en-us/bingmaps/rest-services/locations/find-a-location-by-query) in the [file](/lib/provider/data_provider.dart
) at line no 15,16.
   * And run: `flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi`
   * apk will be found at `/build/app/outputs/apk/release`
   
