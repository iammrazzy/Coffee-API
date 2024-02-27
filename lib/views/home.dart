import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffee_api/controllers/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key});

  final _homeController = Get.put(HomeController());
  final _cafeController = Get.put(CoffeeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: _homeController.screens[_homeController.defaultIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                ),
              ),
            ),
            child: NavigationBar(
              height: 60.0,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: _homeController.defaultIndex,
              onDestinationSelected: (newIndex) {
                _homeController.selectedIndex(newIndex);
              },
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'images/coffee-bean.svg',
                    height: 35.0,
                    width: 35.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'images/coffee-bean-filled.svg',
                    height: 35.0,
                    width: 35.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: 'Coffees',
                ),
                NavigationDestination(
                  icon: GetBuilder<CoffeeController>(
                    builder: (_) => badges.Badge(
                      position: BadgePosition.topEnd(top: -15, end: -12),
                      showBadge:_cafeController.cartList.isEmpty ? false : true,
                      badgeContent: Text(_cafeController.cartList.length.toString(),
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: BadgeStyle(
                        shape: BadgeShape.circle,
                        badgeColor: Colors.pink,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SvgPicture.asset(
                        'images/shopping-bag.svg',
                        height: 25.0,
                        width: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  label: 'Cards',
                  selectedIcon: GetBuilder<CoffeeController>(
                    builder: (_) => badges.Badge(
                      position: BadgePosition.topEnd(top: -15, end: -12),
                      showBadge:_cafeController.cartList.isEmpty ? false : true,
                      badgeContent: Text(
                        _cafeController.cartList.length.toString(),
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: BadgeStyle(
                        shape: BadgeShape.circle,
                        badgeColor: Colors.pink,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SvgPicture.asset(
                        'images/shopping-bag-1.svg',
                        height: 25.0,
                        width: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'images/about.svg',
                    height: 30.0,
                    width: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'images/about-filled.svg',
                    height: 30.0,
                    width: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: 'Coffees',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
