import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screen_tester/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  int activePage = 0;
  bool showHome = true;
  bool showThanks = false;
  List itemlist = ["Dead Pixel", "Stuck Pixel", "Hot Pixel"];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    return Scaffold(
      body: showHome
          ? Stack(
              children: [
                Container(
                  color: AppColors.appBackgroundColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: !showThanks
                                      ? 'Hello! \n'
                                      : "Thank you !\n",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: AppColors.appTextColor)),
                              TextSpan(
                                text: !showThanks ? 'Check your\n' : '',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appTextColor),
                              ),
                              TextSpan(
                                text: !showThanks ? 'Screen Now.' : "",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appTextColor),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activePage = index;
                                    });
                                  },
                                  height: 150.0,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                ),
                                items: itemlist.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              color: i == "Hot Pixel"
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  i,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors
                                                          .appPrimaryColor),
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  );
                                }).toList(),
                              ),
                              activePage == 0
                                  ? Container(
                                      height: 1,
                                      width: 1,
                                      color: Colors.black,
                                    )
                                  : activePage == 1
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 1,
                                              width: 1,
                                              color: Colors.red,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 1,
                                              color: Colors.green,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 1,
                                              color: Colors.blue,
                                            )
                                          ],
                                        )
                                      : Container(
                                          height: 1,
                                          width: 1,
                                          color: Colors.white,
                                        )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: activePage,
                              count: itemlist.length,
                              effect: ExpandingDotsEffect(
                                  dotHeight: 4,
                                  dotWidth: 4,
                                  dotColor: AppColors.appPrimaryColor,
                                  activeDotColor: AppColors.appTextColor),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              backgroundColor: AppColors.appPrimaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                showHome = false;
                                count = 0;
                              });
                            },
                            child: Text(
                              !showThanks ? "Start Chekcing" : "Check Again?",
                              style: TextStyle(color: AppColors.appTextColor),
                            )),
                      ),
                      // Center(
                      //   child: TextButton(
                      //       style: TextButton.styleFrom(
                      //         backgroundColor: AppColors.appPrimaryColor,
                      //       ),
                      //       onPressed: () {
                      //         showDialog(
                      //             context: context,
                      //             builder: (BuildContext context) {
                      //               return AlertDialog(
                      //                 title: const Text('Pick a color!'),
                      //                 content: SingleChildScrollView(
                      //                   child: ColorPicker(
                      //                     pickerColor: AppColors.appPrimaryColor,
                      //                     onColorChanged: (col) {},
                      //                   ),
                      //                   // Use Material color picker:
                      //                   //
                      //                   // child: MaterialPicker(
                      //                   //   pickerColor: pickerColor,
                      //                   //   onColorChanged: changeColor,
                      //                   //   showLabel: true, // only on portrait mode
                      //                   // ),
                      //                   //
                      //                   // Use Block color picker:
                      //                   //
                      //                   // child: BlockPicker(
                      //                   //   pickerColor: currentColor,
                      //                   //   onColorChanged: changeColor,
                      //                   // ),
                      //                   //
                      //                   // child: MultipleChoiceBlockPicker(
                      //                   //   pickerColors: currentColors,

                      //                   //   onColorsChanged: changeColors,
                      //                   // ),
                      //                 ),
                      //                 actions: <Widget>[
                      //                   ElevatedButton(
                      //                     child: const Text('Got it'),
                      //                     onPressed: () {
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                   ),
                      //                 ],
                      //               );
                      //             });
                      //       },
                      //       child: Text(
                      //         "Pick colour",
                      //         style: TextStyle(color: AppColors.appTextColor),
                      //       )),
                      // ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: TextButton(
                    onPressed: () {
                      _launchURL();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        showThanks
                            ? "Report Bug or suggestions\n© 4bh1ram"
                            : "",
                        style: TextStyle(color: AppColors.appTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          : GestureDetector(
              onTapDown: (e) {
                var left =
                    e.globalPosition.dx < MediaQuery.of(context).size.width / 2
                        ? true
                        : false;

                setState(() {
                  if (left) {
                    if (count == 0) {
                      showHome = true;
                      showThanks = false;
                    } else {
                      count = count - 1;
                    }
                  } else {
                    if (count == AppColors.listofclours.length - 1) {
                      showThanks = true;
                      showHome = true;
                    } else {
                      count = count + 1;
                    }
                  }
                });
              },
              child: Container(color: AppColors.listofclours[count]),
            ),
    );
  }

  void _launchURL() async {
    if (!await launch("https://abh1ram.web.app/#contact"))
      throw 'Could not launch ';
  }
}
