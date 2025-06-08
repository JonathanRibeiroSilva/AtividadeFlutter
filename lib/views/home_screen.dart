import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodels/crypto_viewmodel.dart';
import '../models/crypto_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptomoedas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CryptoViewModel>().fetchCryptoData();
            },
          ),
        ],
      ),
      body: Consumer<CryptoViewModel>(
        builder: (context, viewModel, child) {
          if (!viewModel.isConnected) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Sem conexão com a internet',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Buscar criptomoedas (separadas por vírgula)',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => viewModel.fetchCryptoData(),
                    ),
                  ),
                  onChanged: (value) {
                    viewModel.setSearchQuery(value);
                  },
                  onSubmitted: (_) {
                    viewModel.fetchCryptoData();
                  },
                ),
              ),
              if (viewModel.error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    viewModel.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Expanded(
                child: viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.cryptos.isEmpty
                        ? const Center(
                            child: Text('Nenhuma criptomoeda encontrada'),
                          )
                        : RefreshIndicator(
                            onRefresh: () => viewModel.fetchCryptoData(),
                            child: ListView.builder(
                              itemCount: viewModel.cryptos.length,
                              itemBuilder: (context, index) {
                                final crypto = viewModel.cryptos[index];
                                return CryptoListItem(crypto: crypto);
                              },
                            ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CryptoListItem extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoListItem({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text('${crypto.symbol} - ${crypto.name}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('USD: ${usdFormat.format(crypto.priceUsd)}'),
            Text('BRL: ${currencyFormat.format(crypto.priceBrl)}'),
          ],
        ),
        onTap: () => _showCryptoDetails(context, crypto),
      ),
    );
  }

  void _showCryptoDetails(BuildContext context, CryptoModel crypto) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${crypto.name}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Símbolo: ${crypto.symbol}'),
            const SizedBox(height: 8),
            Text('Data de Adição: ${crypto.dateAdded}'),
            const SizedBox(height: 8),
            Text('Preço USD: \$${crypto.priceUsd.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Preço BRL: R\$${crypto.priceBrl.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
} 