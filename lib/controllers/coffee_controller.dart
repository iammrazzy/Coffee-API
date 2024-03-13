import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:coffee_api/models/cofffee_model.dart';
import 'package:coffee_api/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class CoffeeController extends GetxController {
  final _apiService = APIService();
  List<CoffeeModel> coffeeList = [];
  List<CoffeeModel> cartList = [];
  List<CoffeeModel> searchedList = [];
  bool isLoading = false;
  int defaultIndex = 0;


  String noImage = 'https://usercontent.one/wp/www.vocaleurope.eu/wp-content/uploads/no-image.jpg?media=1642546813';

  @override
  void onInit() {
    super.onInit();
    getCoffee();
  }

  // get data from API
  Future<void> getCoffee() async {
    try {
      isLoading = true;
      update();
      final result = await _apiService.fetchCoffee();
      coffeeList = result;
    } catch (e) {
      debugPrint('Error fetching coffee: $e');
      showMessage('Error fetching coffee: $e', Colors.red);
    } finally {
      isLoading = false;
      update();
    }
  }

  // save image from the API ( Internet source )
  void saveImage(String imageUrl) async {
    try {
      isLoading = true;
      update();
      String name = DateTime.now().toString();
      final response = await Dio().get(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(minutes: 1),
          validateStatus: (status) => status! < 500,
        ),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: 'Coffee/$name',
      );
      
      print('Result: 👉 $result');
      showMessage('Image saved success!', Colors.indigo);
    } catch (e) {
      print('Error saving image: $e');
      showMessage('Error saving image: $e', Colors.red);
    } finally {
      isLoading = false;
      update();
    }
  }

  // share cafe image URL
  void shareImage(String imageURL)async{
    await Share.shareUri(
      Uri.parse(imageURL),
    );
  }

  // show message
  void showMessage(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  // search coffee by its name region price & description
  void searchCoffee(String query){
    searchedList.assignAll(
      coffeeList.where((cafe){
          final cafeName = cafe.name?.toLowerCase() ?? '';
          final cafeRegion = cafe.region?.toLowerCase() ?? '';
          final cafePrice = cafe.price?.toString().toLowerCase() ?? '';
          final cafeDescription = cafe.description?.toLowerCase() ?? '';
          return cafeName.contains(query.toLowerCase()) || cafeRegion.contains(query.toLowerCase())
          || cafePrice.contains(query.toLowerCase()) || cafeDescription.contains(query.toLowerCase());
        }
      ).toList(),
    );
    update();
  }

  void newIndex(index) {
    defaultIndex = index;
    update();
  }

  // toggle love button
  bool toggleLove(int id) {
    final coffeeItemIndex = coffeeList.indexWhere((item) => item.id == id);
    if (coffeeItemIndex != -1) {
      coffeeList[coffeeItemIndex].isLoved = !coffeeList[coffeeItemIndex].isLoved;
      update();
      return true;
    } else {
      print('Coffee item with id $id not found.');
      return false;
    }
  }

  // increase QTY by each item
  void increaseQty(int id) {
    final coffeeItemIndex = coffeeList.indexWhere((item) => item.id == id);
    if (coffeeItemIndex != -1) {
      coffeeList[coffeeItemIndex].qty++;
      update();
    }
  }

  // decrease QTY by each item
  void decreaseQty(int id) {
    final coffeeItemIndex = coffeeList.indexWhere((item) => item.id == id);
    if (coffeeItemIndex != -1 && coffeeList[coffeeItemIndex].qty > 1) {
      coffeeList[coffeeItemIndex].qty--;
      update();
    }
  }

  // get total QTY by each item
  int totalEachItemQty(int id) {
    final coffeeItemIndex = coffeeList.indexWhere((item) => item.id == id);
    return coffeeItemIndex != -1 ? coffeeList[coffeeItemIndex].qty : 0;
  }

  // get total Price by each item
  double totalEachItemPrice(int id) {
    final coffeeItemIndex = coffeeList.indexWhere((item) => item.id == id);
    if (coffeeItemIndex != -1) {
      final coffeeItem = coffeeList[coffeeItemIndex];
      return coffeeItem.price! * coffeeItem.qty;
    }
    return 0.0;
  }

  // get all total QTY
  int allTotalQty() {
    int totalQty = 0;
    for (var coffeeItem in cartList) {
      totalQty += coffeeItem.qty;
    }
    return totalQty;
  }

  // get all total price
  double allTotalPriceUSA() {
    double totalPrice = 0.0;
    for (var coffeeItem in cartList) {
      totalPrice += coffeeItem.price! * coffeeItem.qty;
    }
    return totalPrice;
  }

  // convert total price to Khmer Riel
  String allTotalPriceKH(double totalPrice) {
    const int conversionRate = 4100;
    int totalPriceKHR = (totalPrice * conversionRate).toInt();
    final formatter = NumberFormat("#,##0 KHR");
    return formatter.format(totalPriceKHR);
  }


  // toggle add to cart
  void toggleCart(CoffeeModel cafe) {
    final index = cartList.indexWhere((item) => item.id == cafe.id);
    if (index != -1) {
      deleteCart(cafe.id!);
    } else {
      addCart(cafe);
    }
  }

  void addCart(CoffeeModel cafe) {
    if (!cartList.contains(cafe)) {
      cafe.isInCart = true; // Set isInCart to true when adding to cart
      cartList.add(cafe);
      showMessage('Added to cart!', Colors.cyan);
      update();
    }
  }

  void deleteCart(int id) {
    final index = cartList.indexWhere((item) => item.id == id);
    if (index != -1) {
      cartList[index].qty = 1;
      cartList[index].isLoved = false;
      cartList[index].isInCart = false; // Set isInCart to false when removing from cart
      cartList.removeAt(index); // Remove the item from the cart
      update();
    }
  }
  
  // check out
  void checkout() {
    try {
      resetDataAfterCheckout();
      showMessage('Checkout successful!', Colors.green);
    } catch (e) {
      print('Error during checkout: $e');
      showMessage('Error during checkout: $e', Colors.red);
    } finally {
      // Clear the cart after checkout, even if an error occurred
      cartList.clear();
      update();
    }
  }

  // reset data
  void resetDataAfterCheckout() {
    for (var coffeeItem in cartList) {
      coffeeItem.qty = 1;
      coffeeItem.isLoved = false;
      coffeeItem.isInCart = false; // Reset isInCart property
    }
    update();
  }
}
