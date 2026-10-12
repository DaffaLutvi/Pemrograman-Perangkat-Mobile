class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String author;
  final int price;
  final String? imageUrl;

  @override
  bool operator ==(Object other) => other is Book && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
