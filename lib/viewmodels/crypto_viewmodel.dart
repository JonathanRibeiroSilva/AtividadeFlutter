import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/crypto_model.dart';
import '../repositories/crypto_repository.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository _repository;
  final Connectivity _connectivity = Connectivity();
  
  List<CryptoModel> _cryptos = [];
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';
  bool _isConnected = true;
  final List<String> defaultSymbols = [
    'BTC', 'ETH', 'SOL', 'BNB', 'BCH', 'MKR', 'AAVE', 'DOT', 'SUI', 'ADA',
    'XRP', 'TIA', 'NEO', 'NEAR', 'PENDLE', 'RENDER', 'LINK', 'TON', 'XAI',
    'SEI', 'IMX', 'ETHFI', 'UMA', 'SUPER', 'FET', 'USUAL', 'GALA', 'PAAL', 'AERO'
  ];

  List<CryptoModel> get cryptos => _cryptos;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get searchQuery => _searchQuery;
  bool get isConnected => _isConnected;

  CryptoViewModel(this._repository) {
    _initConnectivity();
    _setupConnectivityListener();
    fetchCryptoData();
  }

  Future<void> _initConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      _isConnected = connectivityResult != ConnectivityResult.none;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  void _setupConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;
      if (_isConnected) {
        fetchCryptoData();
      }
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchCryptoData() async {
    if (!_isConnected) {
      _error = 'Sem conexão com a internet';
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final symbols = _searchQuery.isEmpty
          ? defaultSymbols
          : _searchQuery
              .split(',')
              .map((symbol) => symbol.trim().toUpperCase())
              .where((symbol) => symbol.isNotEmpty)
              .toList();

      print('Buscando criptomoedas com símbolos: $symbols');
      final result = await _repository.getCryptoData(symbols);
      _cryptos = result;
      print('Criptomoedas encontradas: ${_cryptos.length}');
    } catch (e) {
      _error = 'Erro ao buscar dados: $e';
      print('Erro ao buscar dados: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 