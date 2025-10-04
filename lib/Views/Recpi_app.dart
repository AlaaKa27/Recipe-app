import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Uitls/colors.dart';
import 'package:flutter_reacpi_app/Views/View_all_items.dart';
import 'package:flutter_reacpi_app/Widget/My_icon_button.dart';
import 'package:flutter_reacpi_app/Widget/banner.dart';
import 'package:flutter_reacpi_app/Widget/food_items_display.dart';
import 'package:iconsax/iconsax.dart';

class AppRecpiHome extends StatefulWidget {
  const AppRecpiHome({super.key});

  @override
  State<AppRecpiHome> createState() => _AppRecpiHomeState();
}

class _AppRecpiHomeState extends State<AppRecpiHome> {
  String category = "All";
  // for categories
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("App-Category");
  //for all items display
  Query get fileteredRecipes => FirebaseFirestore.instance
      .collection("Complete-Flutter-App")
      .where("category", isEqualTo: category);
  Query get allRecipes =>
      FirebaseFirestore.instance.collection("Complete-Flutter-App");
  Query get selectedRecpies =>
      category == "All" ? allRecipes : fileteredRecipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const  SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerparts(),
                    mySearchBar(),
                    //for banner
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //for categories
                    selectedCategory(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                      Text(
                      "Quick & Easy",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewAllItems(),
                        ),
                        );
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            color: AppColors.kprimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ],),
                    
                  ],
                ),
              ),
              //for recipes
              StreamBuilder(
                  stream: selectedRecpies.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> recipes =
                          snapshot.data?.docs ?? [];
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, left: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: recipes
                                .map((e) => FoodItemsDisplay(
                                      documentSnapshot: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    }
                    // its means if snapshot has data then show the data otherwise show the progress bar
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
        stream: categoriesItems.snapshots(),
        builder:
            (context, AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  streamSnapshot.data!.docs.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        category = streamSnapshot.data!.docs[index]["Name"];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color:
                            category == streamSnapshot.data!.docs[index]["Name"]
                                ? AppColors.kprimaryColor
                                : Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(right: 20),
                      child: Text(
                        streamSnapshot.data!.docs[index]["Name"],
                        style: TextStyle(
                          color: category ==
                                  streamSnapshot.data!.docs[index]["Name"]
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          // its means if snapshot has data then show the data otherwise show the progress bar
          return Center(child: CircularProgressIndicator());
        }
        );
  }

  Padding mySearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Iconsax.search_normal),
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "Search for recipes",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Row headerparts() {
    return Row(
      children: [
        const Text(
          "What are you\ncooking today?",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const Spacer(),
        ButtonMyIcon(
          icon: Iconsax.notification,
          pressed: () {},
        ),
      ],
    );
  }
}
