import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("kategori sayfası"),
      ),
      body: ResponsiveGridList(
        horizontalGridMargin: 50,
        verticalGridMargin: 50,
        minItemWidth: 100,
        children: List.generate(
          100,
          (index) => GestureDetector(
            onTap: (){
              //Todo: veritabanından gelen veriler gösterilecek
              print(index);
            },
            child: ColoredBox(
              color: Colors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  '$index',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
