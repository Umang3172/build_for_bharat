import 'dart:js';

import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/chatbot_widget.dart';
import 'package:build_for_bharat/modules/products/ui/product_detail_screen.dart';
import 'package:build_for_bharat/openai_service.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/strings.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ItemGridTile extends StatelessWidget {
  // final VoidCallback onTap;

  final ProductModel productDetailModel;

  const ItemGridTile({super.key, required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Handle the click event here, for example, navigate to a new screen.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNewScreen()));
          print('on Tap called');
          String prompt = preparePrompt(productDetailModel);
          // print('prompt is ${prompt}');
          getProductDetails(prompt, context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(productModel: productDetailModel),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: ScreenUtil.sh * 0.32,
                  width: ScreenUtil.sw * 0.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/tshirt_person_4.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 10,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accenColor.withOpacity(0.6),
                    ),
                    child: Icon(
                      Icons.favorite_outline,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accenColor.withOpacity(0.6),
                    ),
                    child: Icon(
                      Icons.bookmark,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Gap.xxxxshg,
            ),
            Text(
              productDetailModel.title,
              style: Styles.tsw400xxs.apply(color: AppColors.primaryTextColor),
            ),
            Text(
              " ${productDetailModel.price}",
              style: Styles.tsw700xxs.apply(color: AppColors.primaryTextColor),
            )
          ],
        ));
  }

  Future<void> getProductDetails(String message, BuildContext context) async {
    OpenAIService openAIService = OpenAIService();
    final _bot = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3bd');
    Map<String, String> aiResponse =
        await openAIService.chatGPTAPI(message, false);
    print('on tag : ${aiResponse['response']}');
    final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        id: const Uuid().v4(),
        text: aiResponse['response']!);

    Provider.of<ProductProvider>(context, listen: false)
        .messages
        .insert(0, botMessage);
    Provider.of<ProductProvider>(context, listen: false).notifyListeners();
  }

  String preparePrompt(ProductModel productDetailModel) {
    String prod_name = productDetailModel.title;
    String prod_price = '${productDetailModel.price}';
    String prod_category = productDetailModel.category;
    double prod_avg_review = productDetailModel.average_review;
    String prod_color = productDetailModel.color;
    String prod_cloth = productDetailModel.cloth_type;
    String prod_weather = productDetailModel.weather_suitable;
    String review1 =
        'title of review : ${productDetailModel.reviews[0].title} description : ${productDetailModel.reviews[0].desc}, rating =  ${productDetailModel.reviews[0].rating}';
    String occasion = productDetailModel.occasion;

    String res =
        'Give me Details of the product with following information and ask me to add to cart -> title : ${prod_name}, price : ${prod_price}, category : ${prod_category}, average review : ${prod_avg_review}, cloth type : ${prod_cloth}, color : ${prod_color}, public review : ${review1}, occasion : ${occasion}';
    return Strings().details + '  ' + res;
  }
}
