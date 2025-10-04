import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Uitls/colors.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kBannerColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 32,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cook The Best\nRecipes At Home",
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: -20,
            child: Image.network("https://pngimg.com/d/chef_PNG190.png"),
          ),
        ],
      ),
    );
  }
}
