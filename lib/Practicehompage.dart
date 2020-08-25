import 'package:ecomerce_ui/constants.dart';
import 'package:ecomerce_ui/models/detail/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/product.dart';

class HomePageP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg'),
          onPressed: () {},
          color: kTextColor,
        ),
        actions: [
          IconButton(
            icon:
                SvgPicture.asset('assets/icons/search.svg', color: kTextColor),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/cart.svg', color: kTextColor),
            onPressed: () {},
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          )
        ],
      ),
      body: BodyScaffold(),
    );
  }
}

class BodyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 3),
          child: Text(
            'Women',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
            child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 15),
          child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: kDefaultPadding),
              itemBuilder: (context, index) {
                return ItemCard(
                  products: products[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                product: products[index],
                              ))),
                );
              }),
        ))
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product products;
  final Function press;
  ItemCard({this.press, this.products});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Hero(
                    tag: "${products.id}", child: Image.asset(products.image)),
              ),
              decoration: BoxDecoration(
                  color: products.color,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              // products is out demo list
              products.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${products.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Hand Bag",
    "Jewellery",
    "Footwear",
    "Dresses",
    "Watch"
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return buildCategory(index);
          }),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                  color: selectedIndex == index ? kTextColor : kTextLightColor,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                margin: EdgeInsets.only(top: kDefaultPadding / 4),
                height: 2,
                width: 30,
                color:
                    selectedIndex == index ? Colors.black : Colors.transparent)
          ],
        ),
      ),
    );
  }
}
