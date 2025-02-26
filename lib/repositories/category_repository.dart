import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/add_expense/models/category.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Category>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();
    });
  }

  Future<void> addCategory(Category category) async {
    DocumentReference docRef = _firestore.collection('categories').doc(); // Auto-generated ID
    Category newCategory = Category(
      id: docRef.id,
      name: category.name,
      iconCodePoint: category.iconCodePoint,
      iconFontFamily: category.iconFontFamily,
      colorValue: category.colorValue,
    );
    await docRef.set(newCategory.toMap());
  }
}
