import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController placeController = TextEditingController();
  WeatherServices weatherServices = WeatherServices();
  Weather weather = Weather();
  bool isClicked = false;
  double temp = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: TextFormField(
              controller: placeController,
              decoration: InputDecoration(
                hintText: "Enter Place",
                hintStyle: GoogleFonts.poppins(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                getWeatherData();
                // print(weather.tempC);
                setState(() {
                  isClicked = true;
                });
              },
              child: SingleChildScrollView(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: isClicked
                        ? Text(
                            "Update Location",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )
                        : Text(
                            "Search",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ),
          isClicked ? displayData() : const Text(""),
        ],
      ),
    );
  }

  void getWeatherData() async {
    weather = await weatherServices.getWeather(placeController.text);
    setState(() {
      temp = weather.tempC;
    });
    // print(weather.tempC);
    // print(weather.humidity);
  }

  Widget displayData() {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  placeController.text.toString(),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      weather.condition.toString(),
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    Image(image: NetworkImage("https:${weather.image}")),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${temp.toString()} ℃",
                        style: GoogleFonts.lobsterTwo(
                            color: Colors.white, fontSize: 45)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 65,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 52, 52, 52),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.air,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    Text(
                                      "${weather.windMph.toString()} mph",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.thermostat,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    Text(
                                      weather.humidity.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
