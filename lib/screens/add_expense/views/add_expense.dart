import 'dart:math';

import 'package:PocketFlow/screens/add_expense/blocs/category/category_bloc.dart';
import 'package:PocketFlow/screens/add_expense/blocs/category/category_event.dart';
import 'package:PocketFlow/screens/add_expense/blocs/category/category_state.dart';
import 'package:PocketFlow/screens/add_expense/models/category.dart';
import 'package:PocketFlow/screens/add_expense/views/create_category_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_icons/food_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  Color selectedColor = Colors.blue;
  Color iconcolor = Colors.grey;
  Color selectedColor2 = Colors.white;
  IconData selectedIcon = CupertinoIcons.cart;
  IconData selectedIcon2 = FontAwesomeIcons.list;
  String? savedCategoryName;
  bool isexpanded = false;
  bool isrounded = false;
  List<Category> categories = [
    Category(
      id: "1",
      name: "Food",
      iconCodePoint: Icons.fastfood.codePoint,
      iconFontFamily: Icons.fastfood.fontFamily!,
      colorValue: Colors.red.value,
    ),
    Category(
      id: "2",
      name: "Transport",
      iconCodePoint: Icons.directions_car.codePoint,
      iconFontFamily: Icons.directions_car.fontFamily!,
      colorValue: Colors.blue.value,
    ),
    Category(
      id: "3",
      name: "Shopping",
      iconCodePoint: Icons.shopping_cart.codePoint,
      iconFontFamily: Icons.shopping_cart.fontFamily!,
      colorValue: Colors.green.value,
    ),
    Category(
      id: "4",
      name: "Health",
      iconCodePoint: Icons.favorite.codePoint,
      iconFontFamily: Icons.favorite.fontFamily!,
      colorValue: Colors.purple.value,
    ),
    Category(
      id: "5",
      name: "Entertainment",
      iconCodePoint: Icons.music_note.codePoint,
      iconFontFamily: Icons.music_note.fontFamily!,
      colorValue: Colors.orange.value,
    ),
  ];

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

void _showCreateCategoryDialog() async {
  final result = await showCreateCategoryDialog(context: context);

  if (result != null) {
    final Color selectedColor = result['color'];
    final IconData selectedIcon = result['icon'];
    final Category newCategory = result['category'];

    // Update the local state
    setState(() {
      selectedColor2 = selectedColor;
      selectedIcon2 = selectedIcon;
      categoryController.text = newCategory.name;
      savedCategoryName = newCategory.name;
      iconcolor = Colors.white;
    });

    // Add the new category to the BLoC
    context.read<CategoryBloc>().add(AddCategory(newCategory));
  }
}
  //   Color tempColor = selectedColor;
  //   IconData tempIcon = selectedIcon;
  //   TextEditingController tempCategoryController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setDialogState) {
  //           return AlertDialog(
  //             backgroundColor: const Color.fromARGB(255, 215, 241, 252),
  //             title: const Text('Create a Category', textAlign: TextAlign.center),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const SizedBox(height: 16),
  //                 TextFormField(
  //                   controller: tempCategoryController,
  //                   textAlignVertical: TextAlignVertical.center,
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     fillColor: Colors.white,
  //                     hintText: 'Name',
  //                     hintStyle: const TextStyle(color: Colors.grey),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                       borderSide: BorderSide.none,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Padding(
  //                       padding: EdgeInsets.only(left: 8.0),
  //                       child: Text("Icon:", style: TextStyle(fontSize: 16)),
  //                     ),
  //                     CircleAvatar(
  //                       backgroundColor: Colors.white,
  //                       radius: 18,
  //                       child: Icon(tempIcon, color: Colors.black),
  //                     ),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color.fromARGB(255, 157, 195, 213)),
  //                       onPressed: () {
  //                         showDialog(
  //                           context: context,
  //                           builder: (context) {
  //                             return AlertDialog(
  //                               title: const Text('Select an Icon'),
  //                               content: SizedBox(
  //                                 height: 250,
  //                                 width: 300,
  //                                 child: GridView.builder(
  //                                   shrinkWrap: true,
  //                                   gridDelegate:
  //                                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                                     crossAxisCount: 4,
  //                                     crossAxisSpacing: 10,
  //                                     mainAxisSpacing: 10,
  //                                   ),
  //                                   itemCount: 20,
  //                                   itemBuilder: (context, i) {
  //                                     List<IconData> icons = [
  //                                       CupertinoIcons.cart,
  //                                       FoodIcons.bowl,
  //                                       CupertinoIcons.car,
  //                                       CupertinoIcons.house,
  //                                       CupertinoIcons.heart,
  //                                       CupertinoIcons.headphones,
  //                                       CupertinoIcons.clock,
  //                                       CupertinoIcons.book,
  //                                       CupertinoIcons.person_3,
  //                                       CupertinoIcons.bookmark,
  //                                       CupertinoIcons.tag,
  //                                       CupertinoIcons.money_dollar,
  //                                       CupertinoIcons.location,
  //                                       CupertinoIcons.creditcard,
  //                                       CupertinoIcons.umbrella,
  //                                       CupertinoIcons.camera,
  //                                       CupertinoIcons.airplane,
  //                                       CupertinoIcons.music_note,
  //                                       CupertinoIcons.bell,
  //                                       CupertinoIcons.lightbulb,
  //                                     ];

  //                                     return GestureDetector(
  //                                       onTap: () {
  //                                         setDialogState(() {
  //                                           tempIcon = icons[i];
  //                                         });
  //                                         Navigator.pop(context);
  //                                       },
  //                                       child: Container(
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.white,
  //                                           borderRadius: BorderRadius.circular(10),
  //                                         ),
  //                                         child: Center(
  //                                           child: Icon(icons[i],
  //                                               size: 30, color: Colors.black),
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       },
  //                       child: const Text("Pick Icon",
  //                           style: TextStyle(color: Colors.white)),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Padding(
  //                       padding: EdgeInsets.only(left: 8.0),
  //                       child: Text("Color:", style: TextStyle(fontSize: 16)),
  //                     ),
  //                     CircleAvatar(
  //                       backgroundColor: tempColor,
  //                       radius: 15,
  //                     ),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color.fromARGB(255, 157, 195, 213)),
  //                       onPressed: () {
  //                         showDialog(
  //                           context: context,
  //                           builder: (context) {
  //                             return AlertDialog(
  //                               title: const Text('Select a Color'),
  //                               content: Wrap(
  //                                 spacing: 10,
  //                                 runSpacing: 10,
  //                                 children: [
  //                                   for (Color color in [
  //                                     Colors.red,
  //                                     Colors.pink,
  //                                     Colors.purple,
  //                                     Colors.deepPurple,
  //                                     Colors.blue,
  //                                     Colors.lightBlue,
  //                                     Colors.cyan,
  //                                     Colors.teal,
  //                                     Colors.green,
  //                                     Colors.lightGreen,
  //                                     Colors.lime,
  //                                     Colors.yellow,
  //                                     Colors.orange,
  //                                     Colors.deepOrange,
  //                                     Colors.brown
  //                                   ])
  //                                     GestureDetector(
  //                                       onTap: () {
  //                                         setDialogState(() {
  //                                           tempColor = color;
  //                                         });
  //                                         Navigator.pop(context);
  //                                       },
  //                                       child: CircleAvatar(
  //                                         backgroundColor: color,
  //                                         radius: 20,
  //                                         child: tempColor == color
  //                                             ? const Icon(Icons.check,
  //                                                 color: Colors.white)
  //                                             : null,
  //                                       ),
  //                                     ),
  //                                 ],
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       },
  //                       child: const Text("Pick Color",
  //                           style: TextStyle(color: Colors.white)),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 ElevatedButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: WidgetStateProperty.all<Color>(
  //                         const Color.fromARGB(255, 49, 86, 126)),
  //                   ),
  //                   onPressed: () {
  //                     if (tempCategoryController.text.trim().isEmpty) {
  //                       return;
  //                     }

  //                     final String categoryId = FirebaseFirestore.instance
  //                         .collection('categories')
  //                         .doc()
  //                         .id;

  //                     final newCategory = Category(
  //                       id: categoryId,
  //                       name: tempCategoryController.text.trim(),
  //                       iconCodePoint: tempIcon.codePoint,
  //                       iconFontFamily: tempIcon.fontFamily!,
  //                       colorValue: tempColor.value,
  //                     );

  //                     context.read<CategoryBloc>().add(AddCategory(newCategory));

  //                     setState(() {
  //                       selectedColor = tempColor;
  //                       selectedColor2 = tempColor;
  //                       selectedIcon = tempIcon;
  //                       selectedIcon2 = tempIcon;
  //                       categoryController.text = tempCategoryController.text;
  //                       savedCategoryName = tempCategoryController.text.trim();
  //                       iconcolor = Colors.white;
  //                     });

  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("Save Category",
  //                       style: TextStyle(color: Colors.white)),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showCategoryList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6, // Adjust height to 60% of the screen
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              List<Category> allCategories = [...categories];
              if (state is CategoryLoaded) {
                allCategories.addAll(state.categories);
              }

              return Container(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    Category category = allCategories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor2 = Color(category.colorValue);
                          selectedIcon2 = IconData(category.iconCodePoint,
                              fontFamily: category.iconFontFamily);
                          categoryController.text = category.name;
                          savedCategoryName = category.name;
                          iconcolor = Colors.white;
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(category.colorValue),
                            radius: 20,
                            child: Icon(
                              IconData(category.iconCodePoint,
                                  fontFamily: category.iconFontFamily),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.name,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(FontAwesomeIcons.indianRupeeSign,
                        size: 16, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: _showCategoryList,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 19, horizontal: 12),
                  prefixIcon: GestureDetector(
                    onTap: _showCategoryList,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: CircleAvatar(
                        radius: 19,
                        backgroundColor: selectedColor2,
                        child: Icon(selectedIcon2, color: iconcolor, size: 14),
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _showCreateCategoryDialog,
                    icon: const Icon(FontAwesomeIcons.plus,
                        size: 16, color: Colors.grey),
                  ),
                  hintText: savedCategoryName ?? 'Category',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: isexpanded
                          ? const BorderRadius.vertical(top: Radius.circular(12))
                          : BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );

                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(FontAwesomeIcons.clock,
                      size: 16, color: Colors.grey),
                  hintText: 'Date',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}