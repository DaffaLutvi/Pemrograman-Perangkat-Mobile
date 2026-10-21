class TourPackage {
  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;

  String get formattedPrice {
    final priceText = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return 'Rp $priceText';
  }
}
