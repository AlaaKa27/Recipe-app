import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Provider/favotite_provider.dart';
import 'package:flutter_reacpi_app/Provider/quantity.dart';

import 'package:flutter_reacpi_app/Uitls/colors.dart';
import 'package:flutter_reacpi_app/Widget/My_icon_button.dart';
import 'package:flutter_reacpi_app/Widget/quanttity_increment.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const RecipeDetailScreen({super.key, required this.documentSnapshot});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
  
    List<double> baseAmounts = widget.documentSnapshot["ingredientsAmount"]
        .map<double>(
          (amount) => double.parse(
            amount.toString(),
          ),
        )
        .toList();
    Provider.of<QuantityProvider>(context, listen: false)
        .SetBaseIngredientAmounts(baseAmounts);
    super.initState();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final Providerquantity = Provider.of<QuantityProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: startCookingAndFavoriteButton(favoriteProvider),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //for image
                Hero(
                  tag: widget.documentSnapshot["image"],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.documentSnapshot["image"],
                        ),
                      ),
                    ),
                  ),
                ),
                //for back button
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      ButtonMyIcon(
                        icon: Icons.arrow_back_ios_new,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      ButtonMyIcon(
                        icon: Iconsax.notification,
                        pressed: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            // for drag handle
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.documentSnapshot["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.flash_1,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.documentSnapshot['cal']} cal",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Iconsax.clock5,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.documentSnapshot['time']} min",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //for rating
                  Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        widget.documentSnapshot['rating'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "/5",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.documentSnapshot['reviews'.toString()]} Reviews",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Inferdients",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "How many sevings?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      //for quantity increment
                      QuanttityIncrement(
                        CurrentNumber: Providerquantity.currenNumber,
                        onAdd: () => Providerquantity.increaseQuantity(),
                        onRemove: () => Providerquantity.decreaseQuantity(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: widget
                                .documentSnapshot["ingredientsImage"]
                                .map<Widget>(
                                  (imageurl) => Container(
                                    height: 60,
                                    width: 60,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(imageurl),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.documentSnapshot["ingredientsName"]
                                .map<Widget>(
                                  (ingredient) => SizedBox(
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        ingredient,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                       Spacer(),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.documentSnapshot["ingredientsAmount"]
                                    .map<Widget>(
                                      (amount) => SizedBox(
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            "${amount} gm",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton(
      FavoriteProvider Provider) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kBannerColor,
              padding: EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 11,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Text(
              "Start Cooking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            style: IconButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            onPressed: () {
              Provider.toggleFavorite(widget.documentSnapshot);
            },
            icon: Icon(
              Provider.isExist(widget.documentSnapshot)
                  ? Iconsax.heart5
                  : Iconsax.heart,
              color: Provider.isExist(widget.documentSnapshot)
                  ? Colors.red
                  : Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
