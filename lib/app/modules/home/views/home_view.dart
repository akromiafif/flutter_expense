import 'package:expense/app/constant/color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [appYellowSoft, appPrimary.withOpacity(0.2)],
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: <Widget>[
              Row(
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
                    icon: Icon(
                      Icons.notifications,
                      color: appPrimary,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
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
        )
      ],
    ));
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
      width: Get.width * 0.4,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isIncome ? appGreen : appRed,
        borderRadius: BorderRadius.circular(20),
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
                      fontSize: 18,
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
