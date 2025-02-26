class Category {
  final String id;
  final String name;
  final int iconCodePoint; // Storing icon as int (codePoint)
  final String? iconFontFamily; // Storing fontFamily for correct icon retrieval
  final int colorValue; // Store color as int for easy use in Flutter UI

  Category({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    this.iconFontFamily,
    required this.colorValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'colorValue': colorValue,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconCodePoint: map['iconCodePoint'],
      iconFontFamily: map['iconFontFamily'],
      colorValue: map['colorValue'],
    );
  }
}
