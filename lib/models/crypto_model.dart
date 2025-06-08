class CryptoModel {
  final String symbol;
  final String name;
  final double priceUsd;
  final double priceBrl;
  final String dateAdded;
  final int isActive;

  CryptoModel({
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.priceBrl,
    required this.dateAdded,
    required this.isActive,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    try {
      final quote = json['quote'] as Map<String, dynamic>;
      final brlQuote = quote['BRL'] as Map<String, dynamic>;
      
      return CryptoModel(
        symbol: json['symbol'] as String,
        name: json['name'] as String,
        priceUsd: (brlQuote['price'] as num).toDouble(),
        priceBrl: (brlQuote['price'] as num).toDouble(),
        dateAdded: json['date_added'] as String,
        isActive: json['is_active'] as int,
      );
    } catch (e) {
      print('Erro ao converter JSON: $e');
      print('JSON recebido: $json');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'CryptoModel(symbol: $symbol, name: $name, priceUsd: $priceUsd, priceBrl: $priceBrl)';
  }
} 