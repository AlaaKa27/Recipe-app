import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Provider/favotite_provider.dart';
import 'package:flutter_reacpi_app/Uitls/colors.dart';

import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final Provider = FavoriteProvider.of(context);
    final favoriteItems = Provider.favorits;
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kbackgroundColor,
        centerTitle: true,
        title: Text(
          "Favorites ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favoriteItems.isEmpty
          ? Center(
              child: Text(
                "No Favorites Yet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, Index) {
                String favorite = favoriteItems[Index];
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Complete-Flutter-App")
                      .doc(favorite)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Text("Error Loading Favorites"),
                      );
                    }
                    var favoriteItem = snapshot.data!;
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        favoriteItem["image"],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favoriteItem["name"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.flash_1,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "${favoriteItem['cal']}cal",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " . ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Icon(
                                          Iconsax.clock,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${favoriteItem['time']} Min",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //for delete bottun
                        Positioned(
                          top: 50,
                          right: 35,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Provider.toggleFavorite(favoriteItem);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
