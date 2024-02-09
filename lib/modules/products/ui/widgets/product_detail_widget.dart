import 'package:build_for_bharat/common/models/customerReviews.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/glowing_button.dart';
import 'package:build_for_bharat/modules/products/enums/product_bottom_tabs_enum.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductImageDisplayWidget(
              productModel: productModel,
            ),
            SizedBox(
              width: 20,
            ),
            ProductDetailDisplayWidget(
              productModel: productModel,
            ),
          ],
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        BottomReviewsDiscussionWidget(
          productModel: productModel,
        )
      ],
    );
  }
}

class BottomReviewsDiscussionWidget extends StatefulWidget {
  final ProductModel productModel;
  const BottomReviewsDiscussionWidget({
    super.key,
    required this.productModel,
  });

  @override
  State<BottomReviewsDiscussionWidget> createState() =>
      _BottomReviewsDiscussionWidgetState();
}

class _BottomReviewsDiscussionWidgetState
    extends State<BottomReviewsDiscussionWidget> {
  ProductBottomTabEnum productBottomTabEnum = ProductBottomTabEnum.details;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  productBottomTabEnum = ProductBottomTabEnum.details;
                });
              },
              child: Text(
                'Details',
                style: Styles.tsBoldLarge.apply(
                    color: productBottomTabEnum == ProductBottomTabEnum.details
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor),
              ),
            ),
            SizedBox(
              width: Gap.swg,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  productBottomTabEnum = ProductBottomTabEnum.reviews;
                });
              },
              child: Text(
                'Reviews',
                style: Styles.tsBoldLarge.apply(
                    color: productBottomTabEnum == ProductBottomTabEnum.reviews
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor),
              ),
            ),
            SizedBox(
              width: Gap.swg,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  productBottomTabEnum = ProductBottomTabEnum.discussion;
                });
              },
              child: Text(
                'Discussion',
                style: Styles.tsBoldLarge.apply(
                    color:
                        productBottomTabEnum == ProductBottomTabEnum.discussion
                            ? AppColors.primaryTextColor
                            : AppColors.secondaryTextColor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Gap.xxxshg,
        ),
        Container(
            child: productBottomTabEnum == ProductBottomTabEnum.reviews
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CommentsTile(
                        customerReviews: widget.productModel.reviews[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: Gap.xxxshg,
                        ),
                    itemCount: widget.productModel.reviews.length)
                : productBottomTabEnum == ProductBottomTabEnum.details
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.productModel.title,
                          style: Styles.tsw400xs,
                        ),
                      )
                    : Container())
      ],
    );
  }
}

class CommentsTile extends StatelessWidget {
  final CustomerReviews customerReviews;

  const CommentsTile({super.key, required this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: ScreenUtil.sw * 0.02,
          width: ScreenUtil.sw * 0.02,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/header_bg_girl.jpg'),
            ),
          ),
        ),
        SizedBox(
          width: Gap.xxswg,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Helen M.',
                  style:
                      Styles.tsw700s.apply(color: AppColors.primaryTextColor),
                ),
                SizedBox(
                  width: Gap.xxswg,
                ),
                RatingBarIndicator(
                  rating: double.parse(customerReviews.rating),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            SizedBox(
              height: Gap.xxxxshg,
            ),
            Text(
              customerReviews.title,
              style: Styles.tsw400xs.apply(color: AppColors.primaryTextColor),
            ),
            SizedBox(
              height: Gap.xxxxshg,
            ),
            Text(
              customerReviews.desc,
              style: Styles.tsw300xs.apply(color: AppColors.secondaryTextColor),
            ),
          ],
        )
      ],
    );
  }
}

class ProductDetailDisplayWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailDisplayWidget({super.key, required this.productModel});

  @override
  State<ProductDetailDisplayWidget> createState() =>
      _ProductDetailDisplayWidgetState();
}

class _ProductDetailDisplayWidgetState
    extends State<ProductDetailDisplayWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.productModel.average_review);
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil.sw * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productModel.brand,
            style: Styles.tsw400xs,
          ),
          SizedBox(
            height: Gap.xxxshg,
          ),
          Text(
            widget.productModel.title,
            style: Styles.ts500l,
          ),
          SizedBox(
            height: Gap.xxxxshg,
          ),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.productModel.average_review,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              SizedBox(
                width: Gap.xswg,
              ),
              Text(
                '${widget.productModel.reviews.length} reviews',
                style:
                    Styles.tsw400xs.apply(color: AppColors.secondaryTextColor),
              )
            ],
          ),
          SizedBox(
            height: Gap.xxshg,
          ),
          Text(
            '₹${widget.productModel.price}',
            style:
                Styles.largeHeaderText.apply(color: AppColors.primaryTextColor),
          ),
          SizedBox(
            height: Gap.xxshg,
          ),
          Row(
            children: [
              Text(
                'Size',
                style: Styles.tsw400xs.apply(color: AppColors.primaryTextColor),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 4,
                width: 4,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryTextColor),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.productModel.sizes[_selectedIndex],
                style: Styles.tsw400xs.apply(color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            height: Gap.xxxxshg,
          ),
          Wrap(
              children: widget.productModel.sizes.mapIndexed((index, element) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedIndex == index
                          ? AppColors.primaryColor
                          : AppColors.accenColor,
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Center(
                    child: Text(
                      element,
                      style: Styles.tsw300s.apply(
                          color: _selectedIndex == index
                              ? AppColors.accenColor
                              : AppColors.primaryTextColor),
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
          SizedBox(
            height: Gap.xxxshg,
          ),
          Text(
            'Size Guide',
            style: Styles.tsw400xxs.apply(color: AppColors.secondaryTextColor),
          ),
          SizedBox(
            height: Gap.xxshg,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: ScreenUtil.sw * 0.13,
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
                        Icons.shopping_bag,
                        color: AppColors.accenColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Add to cart',
                        style:
                            Styles.tsw400xs.apply(color: AppColors.accenColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              GlowingButton(
                color1: Colors.pinkAccent,
                color2: Colors.indigoAccent,
              ),
            ],
          ),
          SizedBox(
            height: Gap.xxxshg,
          ),
          Row(
            children: [
              const Icon(Icons.fire_truck),
              SizedBox(width: Gap.xswg),
              Text(
                'Free delivery on Orders above ₹299',
                style:
                    Styles.tsw400xxs.apply(color: AppColors.secondaryTextColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductImageDisplayWidget extends StatefulWidget {
  const ProductImageDisplayWidget({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<ProductImageDisplayWidget> createState() =>
      ProductImageDisplayWidgetState();
}

class ProductImageDisplayWidgetState extends State<ProductImageDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: ScreenUtil.sh * 0.75,
          width: ScreenUtil.sw * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.productModel.productImg),
            ),
          ),
        ),
        SizedBox(
          height: Gap.xxshg,
        ),
        Row(
          children: [
            Container(
              height: ScreenUtil.sh * 0.2,
              width: ScreenUtil.sw * 0.084,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/tshirt_person_1.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: Gap.xswg,
            ),
            Container(
              height: ScreenUtil.sh * 0.2,
              width: ScreenUtil.sw * 0.084,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/tshirt_person_1.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: Gap.xswg,
            ),
            Container(
              height: ScreenUtil.sh * 0.2,
              width: ScreenUtil.sw * 0.084,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/tshirt_person_1.jpg'),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
