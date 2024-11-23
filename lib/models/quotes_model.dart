class QuotesPedia {
  final String quote;
  final String authorName;
  final String category;

  QuotesPedia({
    required this.quote,
    required this.authorName,
    required this.category,
  });

  // Factory method to parse JSON into a QuotesPedia object
  factory QuotesPedia.fromJson(Map<String, dynamic> json) {
    return QuotesPedia(
      quote: json['quote'] as String,
      authorName: json['author'] ?? 'Unknown', // Fallback to 'Unknown'
      category: json['category'] ?? 'General', // Fallback to 'General'
    );
  }
}
