import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:coffee_api/views/coffee_detail_screen.dart';
import 'package:coffee_api/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCoffeeScreen extends StatelessWidget {
  AllCoffeeScreen({super.key});

  final _cafeController = Get.put(CoffeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
          ),
        ),
        toolbarHeight: 80.0,
        title: Text(
          'All Coffee',
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
      body: GetBuilder<CoffeeController>(
        builder: (_){
          if(_cafeController.isLoading){
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }else if(_cafeController.coffeeList.isEmpty){
            return Center(
              child:  Text(
                'No data!',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                ),
              ),
            );
          }else{
            return RefreshIndicator(
              onRefresh: () {
                return _cafeController.getCoffee();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _cafeController.coffeeList.length,
                itemBuilder: (context, index) {
                final cafe = _cafeController.coffeeList[index];
                return GestureDetector(
                  onTap: (){
                    Get.to(()=> CoffeeDetailScreen(cafe: cafe));
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
                                        imageUrl: cafe.imageUrl ??_cafeController.noImage,
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
                                                Icons.place_outlined,
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
                                                      _cafeController.toggleLove(cafe.id!);
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
                                                      _cafeController.toggleCart(cafe);
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
              },),
            );
          }
        }
      ),
    );
  }
}