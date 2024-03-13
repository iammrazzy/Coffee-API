import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:coffee_api/models/cofffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CoffeeDetailScreen extends StatelessWidget {
  CoffeeDetailScreen({super.key, required this.cafe});

  final CoffeeModel cafe;
  final _cafeController = Get.put(CoffeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CoffeeController>(
        builder: (_) {
          return Column(
            children: [
              // coffee detail
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      SizedBox(
                        height: 350.0,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: cafe.imageUrl ?? _cafeController.noImage,
                          imageBuilder: (context, imageProvider) {
                            return Stack(
                              children: [
                                // image
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(130.0),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                      
                                // group button
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0,
                                    vertical: 20.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      SafeArea(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                                              
                                            // back button
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color:Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ),
                                                              
                                            // save & share image
                                            Row(
                                              children: [

                                                // save image
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    onPressed: (){
                                                      _cafeController.saveImage(cafe.imageUrl.toString());
                                                    },
                                                    icon: _cafeController.isLoading
                                                    ? CircularProgressIndicator.adaptive()
                                                    : Icon(
                                                      Icons.save_alt_outlined,
                                                      color: Theme.of(context).primaryColor,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(width: 10.0),

                                                // share image url
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    onPressed: (){
                                                      _cafeController.shareImage(cafe.imageUrl.toString());
                                                    },
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Theme.of(context).primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                      
                                      // favorite button
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            _cafeController.toggleLove(cafe.id!);
                                          },
                                          icon: Icon(
                                            cafe.isLoved
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                color: Theme.of(context).primaryColor.withOpacity(.5),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(180.0),
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    _cafeController.noImage,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // other details
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 25.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name & price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.pink,
                                  child: Text(
                                    cafe.name??'No name',
                                    style: GoogleFonts.kantumruyPro(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   cafe.name ?? 'No name',
                                //   style: GoogleFonts.kantumruyPro(
                                //     fontSize: 25.0,
                                //     fontWeight: FontWeight.bold,
                                //     color: Theme.of(context).primaryColor,
                                //   ),
                                // ),
                                Text(
                                  '\$${cafe.price}',
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),

                            // region
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.pink,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        cafe.region??'No name',
                                        style: GoogleFonts.kantumruyPro(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            // qty & total price
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // left
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _cafeController.decreaseQty(cafe.id!);
                                      },
                                      child: CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                        child: Icon(
                                          Icons.remove,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      '${ _cafeController.totalEachItemQty(cafe.id!).toString()}x',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 18.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    GestureDetector(
                                      onTap: () {
                                        _cafeController.increaseQty(cafe.id!);
                                      },
                                      child: CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                        child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // right
                                Text(
                                  'Total: \$${_cafeController.totalEachItemPrice(cafe.id!)}',
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),

                            // information
                            const SizedBox(height: 40.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Information',
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                
                                const Divider(),

                                // weight
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Weight:',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      '${cafe.weight}g',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),

                                // roast_level
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Roast Level:',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        cafe.roastLevel!.bitLength,
                                        (index) {
                                          return Container(
                                            margin: const EdgeInsets.all(2.0),
                                            height: 10.0,
                                            width: 10.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                // flavor_profile
                                Column(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flavor Profile:',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      cafe.flavorProfile!.toList().toString(),
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),

                                // grind_option
                                Column(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Grind Option:',
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      cafe.grindOption!.toList().toString(),
                                      style: GoogleFonts.kantumruyPro(
                                        fontSize: 15.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // description
                            const SizedBox(height: 40.0),
                            Text(
                              'Description',
                              style: GoogleFonts.kantumruyPro(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const Divider(),
                            Text(
                              cafe.description ?? 'No description',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.kantumruyPro(
                                fontSize: 15.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // add to cart button
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    _cafeController.toggleCart(cafe);
                  },
                  child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: cafe.isInCart
                          ?Colors.pink.withOpacity(0.1)
                          : Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cafe.isInCart ? 'Remove from cart' : 'Add to cart',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: cafe.isInCart ?Colors.pink : Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          SvgPicture.asset(
                            cafe.isInCart
                                ? 'images/shopping-bag-1.svg'
                                : 'images/shopping-bag.svg',
                            height: 25.0,
                            width: 25.0,
                            color: cafe.isInCart ?Colors.pink : Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
