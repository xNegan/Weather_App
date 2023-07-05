import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/app_constant.dart';
import 'package:weather_app/home/controller/home_controller.dart';

import '../../repo/weather_repo/weather_repo.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 10,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: TextField(
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          onChanged: (value) => ref
                              .read(homeProvider.notifier)
                              .setInputValue(value),
                          cursorHeight: 25,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              isDense: true,
                              hintText: 'Enter City ',
                              hintStyle: TextStyle(fontSize: 14),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade300),
                        onPressed: () async {
                          await ref.read(homeProvider).getCurrentWeather();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ref.read(homeProvider.notifier).getLoadingStatus
                  ? CircularProgressIndicator()
                  : ref.read(homeProvider.notifier).getResult != null
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Tempreature',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      ref
                                          .read(homeProvider.notifier)
                                          .getResult!
                                          .tempreature
                                          .toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text('City',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      ref
                                          .read(homeProvider.notifier)
                                          .getResult!
                                          .cityName,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text('Wind Speed',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      ref
                                          .read(homeProvider.notifier)
                                          .getResult!
                                          .windSpeed
                                          .toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text('Humadity',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      ref
                                          .read(homeProvider.notifier)
                                          .getResult!
                                          .humidity
                                          .toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          width: double.infinity,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text('Enter a Valid city name'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.amber.shade200,
                          ),
                        ),
              ElevatedButton(
                  onPressed: () {
                    ref.read(homeProvider.notifier).getForcast();
                  },
                  child: Text('View Weather Forcasts')),
              ref.read(homeProvider.notifier).weatherForcasts.isNotEmpty
                  ? SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: ref
                              .read(homeProvider.notifier)
                              .weatherForcasts
                              .length,
                          itemBuilder: (context, index) =>
                              //////
                              ///
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber[500],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Tempreature',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                            ref
                                                .read(homeProvider.notifier)
                                                .weatherForcasts[index]
                                                .tempreature
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text('Date',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                            ref
                                                .read(homeProvider.notifier)
                                                .weatherForcasts[index]
                                                .date
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text('Wind Speed',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                            ref
                                                .read(homeProvider.notifier)
                                                .weatherForcasts[index]
                                                .windSpeed
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text('Humadity',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                            ref
                                                .read(homeProvider.notifier)
                                                .weatherForcasts[index]
                                                .humidity
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ////////

                          ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
