import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class CryptoRepository {
  final String _baseUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';
  final String _apiKey = 'd61e26ab-8075-436a-b851-a0362fc7a705';

  Future<List<CryptoModel>> getCryptoData(List<String> symbols) async {
    try {
      final symbolString = symbols.join(',');
      final url = Uri.parse('$_baseUrl?symbol=$symbolString&convert=BRL');
      print('Fazendo requisição para: $url');

      final response = await http.get(
        url,
        headers: {
          'X-CMC_PRO_API_KEY': _apiKey,
          'Accept': 'application/json',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cryptoData = data['data'] as Map<String, dynamic>;
        final List<CryptoModel> cryptos = [];

        cryptoData.forEach((symbol, cryptoInfo) {
          try {
            if (cryptoInfo is Map<String, dynamic> && cryptoInfo['is_active'] == 1) {
              cryptos.add(CryptoModel.fromJson(cryptoInfo));
              print('Criptomoeda adicionada: $symbol');
            }
          } catch (e) {
            print('Erro ao processar criptomoeda $symbol: $e');
          }
        });

        print('Total de criptomoedas encontradas: ${cryptos.length}');
        return cryptos;
      } else {
        throw Exception('Falha ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
      rethrow;
    }
  }
} 