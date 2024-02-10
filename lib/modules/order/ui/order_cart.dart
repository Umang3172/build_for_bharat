import 'dart:developer';

import 'package:build_for_bharat/common/models/cart.dart';
import 'package:build_for_bharat/modules/order/ui/widgets/single_item_widget.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({super.key});

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  @override
  Widget build(BuildContext context) {
    final cartItemsList =
        Provider.of<ProductProvider>(context, listen: false).tags.cart;

    log(cartItemsList.toString());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Orders',
              style: Styles.largeHeaderText
                  .apply(color: AppColors.primaryTextColor),
            ),
            SizedBox(
              height: Gap.xxshg,
            ),
            Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(
                  width: Gap.xxswg,
                ),
                Text(
                  DateFormat().format(DateTime.now()),
                  style: Styles.tsw400xs
                      .apply(color: AppColors.secondaryTextColor),
                ),
              ],
            ),
            SizedBox(
              height: Gap.xxshg,
            ),
            cartItemsList.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset('animations/empty_cart.json'),
                        SizedBox(
                          height: Gap.xxshg,
                        ),
                        Text(
                          "Your Cart is Empty!",
                          style: Styles.titleHeaderStyle,
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemImageColumn(
                              cartItems: cartItemsList,
                            ),
                            SizedBox(
                              width: Gap.swg,
                            ),
                            ItemPriceColumn(cartItems: cartItemsList),
                            SizedBox(
                              width: Gap.xxswg,
                            ),
                            ItemQuantityColumn(cartItems: cartItemsList),
                            SizedBox(
                              width: Gap.xxswg,
                            ),
                            TotalPriceColumn(cartItems: cartItemsList)
                          ],
                        ),
                        SizedBox(
                          height: Gap.xxxshg,
                        ),
                        Center(
                          child: SizedBox(
                            width: ScreenUtil.sw * 0.36,
                            height: ScreenUtil.sh * 0.06,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: AppColors.primaryColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: AppColors.accenColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Order',
                                    style: Styles.tsw400xs
                                        .apply(color: AppColors.accenColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}

class TotalPriceColumn extends StatelessWidget {
  final List<Cart> cartItems;
  const TotalPriceColumn({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Price',
          style: Styles.tsw300m.apply(color: AppColors.primaryTextColor),
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        SizedBox(
          width: ScreenUtil.sw * 0.2,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  (cartItems[index].total_price).toString(),
                  style:
                      Styles.tsw700s.apply(color: AppColors.primaryTextColor),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: ScreenUtil.sh * 0.25 + Gap.xxxxshg,
                );
              },
              itemCount: cartItems.length),
        )
      ],
    );
  }
}

class ItemQuantityColumn extends StatelessWidget {
  final List<Cart> cartItems;
  const ItemQuantityColumn({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: Styles.tsw300m.apply(color: AppColors.primaryTextColor),
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        SizedBox(
          width: ScreenUtil.sw * 0.2,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  cartItems[index].count.toString(),
                  style:
                      Styles.tsw700s.apply(color: AppColors.primaryTextColor),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: ScreenUtil.sh * 0.25 + Gap.xxxxshg,
                );
              },
              itemCount: cartItems.length),
        )
      ],
    );
  }
}

class ItemPriceColumn extends StatelessWidget {
  final List<Cart> cartItems;
  const ItemPriceColumn({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: Styles.tsw300m.apply(color: AppColors.primaryTextColor),
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        SizedBox(
          width: ScreenUtil.sw * 0.2,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  (cartItems[index].total_price / cartItems[index].count)
                      .toString(),
                  style:
                      Styles.tsw700s.apply(color: AppColors.primaryTextColor),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: ScreenUtil.sh * 0.25 + Gap.xxxxshg,
                );
              },
              itemCount: cartItems.length),
        )
      ],
    );
  }
}

class ItemImageColumn extends StatelessWidget {
  final List<Cart> cartItems;
  const ItemImageColumn({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: Styles.tsw300m.apply(color: AppColors.primaryTextColor),
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        SizedBox(
          width: ScreenUtil.sw * 0.2,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SingleItemWidget(cartItems: cartItems[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: Gap.xxshg,
                );
              },
              itemCount: cartItems.length),
        )
      ],
    );
  }
}
