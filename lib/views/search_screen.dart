import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/controllers/coffee_controller.dart';
import 'package:coffee_api/views/coffee_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _cafeController = Get.find<CoffeeController>();
  final _controller = TextEditingController();

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
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(10.0),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search coffee',
            hintStyle: GoogleFonts.kantumruyPro(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onChanged: (query) {
            _cafeController.searchCoffee(query);
          },
        ),
      ),
      body: GetBuilder<CoffeeController>(
        builder: (_) {
          if (_cafeController.searchedList.isEmpty) {
            return Center(
              child: Text(
                'No data!',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                  color: Colors.pink,
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () {
                return _cafeController.getCoffee();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _cafeController.searchedList.length,
                itemBuilder: (context, index) {
                  final cafe = _cafeController.searchedList[index];
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
                            SizedBox(
                              height: 170.0,
                              width: 110.0,
                              child: CachedNetworkImage(
                                imageUrl:cafe.imageUrl ?? _cafeController.noImage,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                        image: CachedNetworkImageProvider(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                          // favorite button
                                          GestureDetector(
                                            onTap: () {
                                              _cafeController.toggleLove(cafe.id!);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:Colors.pink.withOpacity(.1),
                                              child: Icon(
                                                cafe.isLoved
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
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
                                              backgroundColor:Colors.pink.withOpacity(.1),
                                              child: Icon(
                                                cafe.isInCart
                                                    ? Icons.shopping_cart
                                                    : Icons
                                                        .shopping_cart_outlined,
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
    );
  }
}
