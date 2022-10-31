import 'package:expense/app/constant/color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  var selected = 2.obs;

  void setSelected(var value) {
    selected.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(17, 21500),
      ChartData(18, 22684),
      ChartData(19, 21643),
      ChartData(20, 22997),
      ChartData(21, 22883),
      ChartData(22, 22635),
      ChartData(23, 21800),
      ChartData(24, 23500),
      ChartData(25, 21354),
      ChartData(26, 22354),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: appYellowSoft.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const CircleAvatar(),
                  Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_down_outlined),
                      Text(
                        "October",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: appPrimary,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: appYellowSoft.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Account Balance",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: appTextSoft,
                    ),
                  ),
                  Text(
                    "\$9400",
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      color: appText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      InfoBalance(
                        isIncome: true,
                        balance: 5000,
                      ),
                      InfoBalance(
                        isIncome: false,
                        balance: 7500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SfCartesianChart(
                    margin: const EdgeInsets.all(0),
                    borderWidth: 0,
                    borderColor: Colors.white,
                    primaryXAxis: NumericAxis(
                      minimum: 17,
                      maximum: 26,
                      interval: 1,
                      isVisible: false,
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 19000,
                      maximum: 24000,
                      interval: 1000,
                      isVisible: false,
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                    ),
                    series: <ChartSeries<ChartData, int>>[
                      SplineAreaSeries(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.day,
                        yValueMapper: (ChartData data, _) => data.price,
                        gradient: LinearGradient(
                          colors: <Color>[
                            appPurpleAccent.withOpacity(0.5),
                            appWhite
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        splineType: SplineType.natural,
                      ),
                      SplineSeries(
                        width: 4,
                        markerSettings: const MarkerSettings(
                          color: appPurpleSoft,
                          borderWidth: 2,
                          shape: DataMarkerType.circle,
                          borderColor: appPurpleAccent,
                          isVisible: true,
                        ),
                        color: appPurpleAccent,
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.day,
                        yValueMapper: (ChartData data, _) => data.price,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 2,
        backgroundColor: appWhiteSoft,
        activeColor: appPrimary,
        style: TabStyle.reactCircle,
        color: appTextSoft,
        height: 70,
        curveSize: 80,
        items: [
          TabItem<Widget>(
            icon: ButtomTabItem(
              selected: selected,
              index: 0,
              imageSource: "assets/icons/home.png",
            ),
            title: 'Home',
          ),
          TabItem(
            icon: ButtomTabItem(
              selected: selected,
              index: 1,
              imageSource: "assets/icons/transaction.png",
            ),
            title: 'Transaction',
          ),
          TabItem(
            icon: ButtomTabItem(
              selected: selected,
              index: 2,
              imageSource: "assets/icons/add.png",
            ),
            title: 'Add',
          ),
          TabItem(
            icon: ButtomTabItem(
              selected: selected,
              index: 3,
              imageSource: "assets/icons/budget.png",
            ),
            title: 'Budget',
          ),
          TabItem(
            icon: ButtomTabItem(
              selected: selected,
              index: 4,
              imageSource: "assets/icons/profile.png",
            ),
            title: 'Profile',
          ),
        ],
        onTap: (int i) => {setSelected(i)},
      ),
    );
  }
}

class ButtomTabItem extends StatelessWidget {
  const ButtomTabItem({
    Key? key,
    required this.selected,
    required this.imageSource,
    required this.index,
  }) : super(key: key);

  final RxInt selected;
  final int index;
  final String imageSource;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(selected.value == index ? 20 : 0),
        child: Image.asset(
          imageSource,
          width: 60,
          height: 60,
          color: selected.value == index ? appWhiteSoft : appTextSoft,
        ),
      ),
    );
  }
}

class InfoBalance extends StatelessWidget {
  const InfoBalance({
    Key? key,
    required this.isIncome,
    required this.balance,
  }) : super(key: key);

  final bool isIncome;
  final int balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isIncome ? appGreen : appRed,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: appWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
                isIncome ? "assets/icons/in.png" : "assets/icons/out.png"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isIncome ? "Income" : "Expenses",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: appWhite,
                  ),
                ),
                const SizedBox(height: 5),
                FittedBox(
                  child: Text(
                    "\$$balance",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: appWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.price);
  final int day;
  final double price;
}
