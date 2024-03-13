import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:coffee_api/views/all_coffee_screen.dart';
import 'package:coffee_api/views/coffee_detail_screen.dart';
import 'package:coffee_api/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class CoffeeScreen extends StatelessWidget {
  CoffeeScreen({Key? key}) : super(key: key);

  final _coffeeController = Get.put(CoffeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
          ),
        ),
        toolbarHeight: 80.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Coffee Shop',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SvgPicture.asset(
                  'images/coffee-bean-filled.svg',
                  height: 35.0,
                  width: 35.0,
                  color: Colors.white,
                ),
              ],
            ),
            Text(
              'Find the best for yourself',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Get.to(() => SearchScreen());
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // image slider
            const SizedBox(height: 10.0),
            GetBuilder<CoffeeController>(
              builder: (_) {
                return Column(
                  children: [
                    CarouselSlider(
                      items: _coffeeController.coffeeList.map((index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => CoffeeDetailScreen(cafe: index));
                          },
                          child: Card(
                            margin: const EdgeInsets.all(0.5),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(0.5),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.none,
                                      image: CachedNetworkImageProvider(
                                        _coffeeController.coffeeList[_coffeeController.defaultIndex].imageUrl ??_coffeeController.noImage,
                                      ),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context).primaryColor.withOpacity(0.5),
                                        Theme.of(context).primaryColor.withOpacity(0.2),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _coffeeController.coffeeList[_coffeeController.defaultIndex].name ?? 'No name',
                                          style: GoogleFonts.kantumruyPro(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.place,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              _coffeeController.coffeeList[_coffeeController.defaultIndex].region ?? 'No name',
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 170.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        onPageChanged: (index, reason) {
                          _coffeeController.newIndex(index);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _coffeeController.coffeeList.map((image) {
                        int index = _coffeeController.coffeeList.indexOf(image);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 2.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _coffeeController.defaultIndex == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColor.withOpacity(.2),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),

            // category header
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // category items
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<CoffeeController>(
                builder: (_) {
                  return Row(
                    children: List.generate(_coffeeController.coffeeList.length,(index) {
                      final cafe = _coffeeController.coffeeList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CoffeeDetailScreen(cafe: cafe));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Container(
                            height: 45.0,
                            width: 100.0,
                            margin: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.1),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  _coffeeController.coffeeList[index].imageUrl ??_coffeeController.noImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            // cafe items header
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Available now',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> AllCoffeeScreen());
                    },
                    child: Text(
                      'See all',
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // cafe items
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<CoffeeController>(
                builder: (_) {
                  if (_coffeeController.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (_coffeeController.coffeeList.isEmpty) {
                    return Center(
                      child: Text(
                        'No data!',
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: List.generate(
                        _coffeeController.coffeeList.length,
                        (index) {
                          final cafe = _coffeeController.coffeeList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => CoffeeDetailScreen(cafe: cafe));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(5.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // image
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(()=> Stack(
                                          alignment: Alignment.topRight,
                                          children: [

                                            // image
                                            PhotoView(
                                              imageProvider: CachedNetworkImageProvider(
                                                cafe.imageUrl??'',
                                              ),
                                            ),

                                            // group icon
                                            SafeArea(
                                              child: Padding(
                                                padding: EdgeInsets.all(20.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [

                                                    // back button
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 25.0,
                                                          color: Theme.of(context).primaryColor,
                                                        ),
                                                      ),
                                                    ),

                                                    // save image button
                                                    const SizedBox(width: 15.0),
                                                    GetBuilder<CoffeeController>(
                                                      builder: (_){
                                                        return CircleAvatar(
                                                          backgroundColor: Colors.white,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              _coffeeController.saveImage(cafe.imageUrl.toString());
                                                            },
                                                            icon: _coffeeController.isLoading
                                                              ? CircularProgressIndicator()
                                                              : Icon(
                                                                Icons.save_alt,
                                                                size: 25.0,
                                                                color: Theme.of(context).primaryColor,
                                                              )
                                                          ),
                                                        );
                                                      }
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                      },
                                      child: SizedBox(
                                        height: 170.0,
                                        width: 110.0,
                                        child: CachedNetworkImage(
                                          imageUrl: cafe.imageUrl ??_coffeeController.noImage,
                                          imageBuilder: (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider,
                                                ),
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:CachedNetworkImageProvider(
                                                    _coffeeController.noImage,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cafe.name ?? 'No name',
                                            style: GoogleFonts.kantumruyPro(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          Text(
                                            cafe.description ?? 'No name',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.kantumruyPro(
                                              fontSize: 15.0,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 2.0),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.place,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              Text(
                                                cafe.region ?? '',
                                                style: GoogleFonts.kantumruyPro(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${cafe.price}',
                                                style: GoogleFonts.kantumruyPro(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _coffeeController.toggleLove(cafe.id!);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.pink.withOpacity(.1),
                                                      child: Icon(
                                                        cafe.isLoved? Icons.favorite: Icons.favorite_border,
                                                        size: 20.0,
                                                        color: Colors.pink,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _coffeeController.toggleCart(cafe);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.pink.withOpacity(.1),
                                                      child: Icon(
                                                        cafe.isInCart
                                                            ?Icons.shopping_cart
                                                            : Icons.shopping_cart_outlined,
                                                        size: 20.0,
                                                        color: Colors.pink,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 25.0),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
