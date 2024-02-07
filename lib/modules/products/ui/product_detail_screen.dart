import 'package:build_for_bharat/basic_layout_widget.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/common/widgets/common_app_bar.dart';
import 'package:build_for_bharat/modules/home/ui/chatbot_widget.dart';
import 'package:build_for_bharat/modules/products/ui/widgets/product_detail_widget.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/strings.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:build_for_bharat/openai_service.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String prompt = preparePrompt(widget.productModel);
    // print('prompt is ${prompt}');
    getProductDetails(prompt, context);
  }

  @override
  Widget build(BuildContext context) {
    return BasicLayoutWidget(
        leftWidget: SingleChildScrollView(
          child: Column(
            children: [
              CommonAppBar(),
              SizedBox(
                height: Gap.xxxxshg,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.productModel.category,
                          style: Styles.tsw400xxs
                              .apply(color: AppColors.primaryTextColor),
                        ),
                        SizedBox(
                          width: Gap.xxswg,
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryTextColor),
                        ),
                        SizedBox(
                          width: Gap.xxswg,
                        ),
                        Text(
                          widget.productModel.brand,
                          style: Styles.tsw400xxs
                              .apply(color: AppColors.primaryTextColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Gap.xxshg,
                    ),
                    ProductDetailWidget(productModel: widget.productModel)
                  ],
                ),
              )
            ],
          ),
        ),
        rightWidget: ChatPage(
          isProduct: true,
        ));
    // rightWidget: const ChatPage());
  }

  Future<void> getProductDetails(String message, BuildContext context) async {
    OpenAIService openAIService =
        Provider.of<ProductProvider>(context, listen: false).openAiService;
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
        '''Give me Details of this product whose product name is ${prod_name} with price  ${prod_price} INR and falls in category  ${prod_category}. Its  average review is ${prod_avg_review} and the cloth type is ${prod_cloth}. The color is ${prod_color} and this is what top public review is ${review1}, occasion suitable for is ${occasion}  and ask me to add to cart. If i say yes then ask quantity of product he wants to add and then calculate total_cost which is an integere as price multiplied by quantity. 
 add the product to cart json Array in tags json where the product_name will be set to the title of the product, quantity will be set to the quantity user wants to add and total_cost is set to the calculated integer we get by multiplying price of the product and quantity user wants to buy.''';
    return res;
  }
}
