import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_icons/food_icons.dart';
import 'package:PocketFlow/screens/add_expense/models/category.dart';
import 'package:PocketFlow/screens/add_expense/blocs/category/category_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> showCreateCategoryDialog({
  required BuildContext context,
}) async {
  Color tempColor = Colors.blue;
  IconData tempIcon = CupertinoIcons.cart;
  TextEditingController tempCategoryController = TextEditingController();

  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 215, 241, 252),
            title: const Text('Create a Category', textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: tempCategoryController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Icon:", style: TextStyle(fontSize: 16)),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(tempIcon, color: Colors.black),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 157, 195, 213)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Select an Icon'),
                              content: SizedBox(
                                height: 250,
                                width: 300,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: 20,
                                  itemBuilder: (context, i) {
                                    List<IconData> icons = [
                                      CupertinoIcons.cart,
                                      FoodIcons.bowl,
                                      CupertinoIcons.car,
                                      CupertinoIcons.house,
                                      CupertinoIcons.heart,
                                      CupertinoIcons.headphones,
                                      CupertinoIcons.clock,
                                      CupertinoIcons.book,
                                      CupertinoIcons.person_3,
                                      CupertinoIcons.bookmark,
                                      CupertinoIcons.tag,
                                      CupertinoIcons.money_dollar,
                                      CupertinoIcons.location,
                                      CupertinoIcons.creditcard,
                                      CupertinoIcons.umbrella,
                                      CupertinoIcons.camera,
                                      CupertinoIcons.airplane,
                                      CupertinoIcons.music_note,
                                      CupertinoIcons.bell,
                                      CupertinoIcons.lightbulb,
                                    ];

                                    return GestureDetector(
                                      onTap: () {
                                        setDialogState(() {
                                          tempIcon = icons[i];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Icon(icons[i],
                                              size: 30, color: Colors.black),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text("Pick Icon",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Color:", style: TextStyle(fontSize: 16)),
                    ),
                    CircleAvatar(
                      backgroundColor: tempColor,
                      radius: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 157, 195, 213)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Select a Color'),
                              content: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for (Color color in [
                                    Colors.red,
                                    Colors.pink,
                                    Colors.purple,
                                    Colors.deepPurple,
                                    Colors.blue,
                                    Colors.lightBlue,
                                    Colors.cyan,
                                    Colors.teal,
                                    Colors.green,
                                    Colors.lightGreen,
                                    Colors.lime,
                                    Colors.yellow,
                                    Colors.orange,
                                    Colors.deepOrange,
                                    Colors.brown
                                  ])
                                    GestureDetector(
                                      onTap: () {
                                        setDialogState(() {
                                          tempColor = color;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: color,
                                        radius: 20,
                                        child: tempColor == color
                                            ? const Icon(Icons.check,
                                                color: Colors.white)
                                            : null,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text("Pick Color",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 49, 86, 126)),
                  ),
                  onPressed: () {
                    if (tempCategoryController.text.trim().isEmpty) {
                      return;
                    }

                    final String categoryId = FirebaseFirestore.instance
                        .collection('categories')
                        .doc()
                        .id;

                    final newCategory = Category(
                      id: categoryId,
                      name: tempCategoryController.text.trim(),
                      iconCodePoint: tempIcon.codePoint,
                      iconFontFamily: tempIcon.fontFamily!,
                      colorValue: tempColor.value,
                    );

                    // Return the selected color, icon, and category name
                    Navigator.pop(context, {
                      'color': tempColor,
                      'icon': tempIcon,
                      'category': newCategory,
                    });
                  },
                  child: const Text("Save Category",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}