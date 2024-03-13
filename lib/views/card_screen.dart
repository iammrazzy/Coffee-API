import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:coffee_api/views/all_coffee_screen.dart';
import 'package:coffee_api/views/coffee_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatelessWidget {
  CardScreen({Key? key}) : super(key: key);

  final _cafeController = Get.put(CoffeeController());

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
        title: Text(
          'My Carts',
          style: GoogleFonts.kantumruyPro(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Get.to(()=> AllCoffeeScreen());
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
      body: GetBuilder<CoffeeController>(
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: GetBuilder<CoffeeController>(
                  builder: (_) {
                    if (_cafeController.cartList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/shopping-bag-1.svg',
                              height: 35.0,
                              width: 35.0,
                              color: Colors.pink,
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'No cart yet!',
                              style: GoogleFonts.kantumruyPro(
                                fontSize: 18.0,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _cafeController.cartList.length,
                        itemBuilder: (context, index) {
                          final cart = _cafeController.cartList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => CoffeeDetailScreen(cafe: cart),
                              );
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
                                    SizedBox(
                                      height: 170.0,
                                      width: 110.0,
                                      child: CachedNetworkImage(
                                        imageUrl: cart.imageUrl ??_cafeController.noImage,
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
                                                  _cafeController.noImage,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cart.name ?? 'No name',
                                            style: GoogleFonts.kantumruyPro(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          Text(
                                            cart.description ?? 'No name',
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
                                                Icons.place_outlined,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              Text(
                                                cart.region ?? '',
                                                style: GoogleFonts.kantumruyPro(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                          GetBuilder<CoffeeController>(
                                            builder: (_) {
                                              return Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // left
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _cafeController.decreaseQty(cart.id!);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 15.0,
                                                          backgroundColor:Colors.pink.withOpacity(.1),
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.pink,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5.0),
                                                      Text(
                                                       '${ _cafeController.totalEachItemQty(cart.id!).toString()}x',
                                                        style: GoogleFonts.kantumruyPro(
                                                          fontSize: 18.0,
                                                          color: Colors.pink,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5.0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _cafeController.increaseQty(cart.id!);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 15.0,
                                                          backgroundColor:Colors.pink.withOpacity(.1),
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.pink,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  // right
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '\$${_cafeController.totalEachItemPrice(cart.id!)}',
                                                        style: GoogleFonts.kantumruyPro(
                                                          fontSize: 18.0,
                                                          fontWeight:FontWeight.bold,
                                                          color: Colors.pink,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10.0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _cafeController.toggleCart(cart);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 15.0,
                                                          backgroundColor:Colors.pink.withOpacity(.1),
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 20.0,
                                                            color: Colors.pink,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
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
                      );
                    }
                  },
                ),
              ),

              // total
              const SizedBox(height: 10.0),
              GetBuilder<CoffeeController>(
                builder: (_) {
                  if (_cafeController.cartList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          // total items
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Items: ${_cafeController.cartList.length}',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                '────────',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 17.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          // total qty
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Quantities: ${_cafeController.allTotalQty().toString()}x',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                '─────────',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 17.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),

                          // total price & discount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'Total Prices: \$${_cafeController.allTotalPriceUSA().toString()}',
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                'Discount: \$${'0.0'}',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 17.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              // check out
              GetBuilder<CoffeeController>(
                builder: (_) {
                  if (_cafeController.cartList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          _cafeController.checkout();
                        },
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Check out',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Icon(
                                Icons.arrow_forward,
                                size: 20.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
