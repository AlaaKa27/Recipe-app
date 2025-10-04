import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Uitls/colors.dart';
import 'package:flutter_reacpi_app/Views/Recpi_app.dart';
import 'package:flutter_reacpi_app/Widget/My_icon_button.dart';
import 'package:flutter_reacpi_app/Widget/food_items_display.dart';
import 'package:iconsax/iconsax.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final CollectionReference completeApp =
      FirebaseFirestore.instance.collection("Complete-Flutter-App");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kbackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          SizedBox(
            width: 10,
          ),
          ButtonMyIcon(
              icon: Icons.arrow_back_ios_new,
              pressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppRecpiHome()));
              }),
          Spacer(),
          Text(
            "Quick & Easy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Spacer(),
          ButtonMyIcon(
            icon: Iconsax.notification,
            pressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 5,
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              StreamBuilder(
                  stream: completeApp.snapshots(),
                  builder:
                      // ignore: non_constant_identifier_names
                      (context, AsyncSnapshot<QuerySnapshot> Streamsnapshot) {
                    if (Streamsnapshot.hasData) {
                      return GridView.builder(
                        itemCount: Streamsnapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                        ),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              Streamsnapshot.data!.docs[index];
                          return Column(
                            children: [
                              FoodItemsDisplay(
                                  documentSnapshot: documentSnapshot),
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
                                    documentSnapshot['rating'],
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
                                    "${documentSnapshot['reviews'.toString()]} Reviews",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
