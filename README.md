# Aplicativo de Criptomoedas

Um aplicativo Flutter que exibe informações sobre criptomoedas usando a API do Coin Market Cap.

## Funcionalidades

- Lista de criptomoedas com preços em USD e BRL
- Busca por múltiplas criptomoedas
- Verificação de conexão com a internet
- Atualização manual e pull-to-refresh
- Detalhes de cada criptomoeda
- Interface moderna e responsiva

## Pré-requisitos

- Flutter SDK (versão 3.0.0 ou superior)
- Dart SDK (versão 3.0.0 ou superior)
- Android Studio / VS Code com extensões Flutter
- Dispositivo Android/iOS ou emulador

## Configuração

1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITÓRIO]
cd [NOME_DO_DIRETÓRIO]
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure a chave da API:
   - Abra o arquivo `lib/repositories/crypto_repository.dart`
   - Substitua a variável `_apiKey` pela sua chave da API do Coin Market Cap:
   ```dart
   final String _apiKey = 'SUA_CHAVE_API_AQUI';
   ```

## Executando o Aplicativo

1. Certifique-se de que um emulador está rodando ou um dispositivo físico está conectado

2. Execute o aplicativo:
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
├── models/
│   └── crypto_model.dart      # Modelo de dados para criptomoedas
├── repositories/
│   └── crypto_repository.dart # Comunicação com a API
├── viewmodels/
│   └── crypto_viewmodel.dart  # Lógica de negócios e estado
├── views/
│   └── home_screen.dart       # Interface do usuário
└── main.dart                  # Ponto de entrada do aplicativo
```

## Uso

1. Ao iniciar, o aplicativo carrega automaticamente as seguintes criptomoedas:
   - BTC, ETH, SOL, BNB, BCH, MKR, AAVE, DOT, SUI, ADA
   - XRP, TIA, NEO, NEAR, PENDLE, RENDER, LINK, TON, XAI
   - SEI, IMX, ETHFI, UMA, SUPER, FET, USUAL, GALA, PAAL, AERO

2. Para buscar criptomoedas específicas:
   - Digite os símbolos no campo de busca, separados por vírgula
   - Exemplo: "btc, eth, sol"
   - Pressione Enter ou clique no ícone de busca

3. Para atualizar os dados:
   - Puxe a lista para baixo (pull-to-refresh)
   - Ou clique no ícone de atualização no canto superior direito

4. Para ver detalhes de uma criptomoeda:
   - Toque em qualquer item da lista

## Tratamento de Erros

- O aplicativo verifica automaticamente a conexão com a internet
- Exibe mensagens de erro quando:
  - Não há conexão com a internet
  - A API retorna um erro
  - Os dados não podem ser processados

## Dependências

- `provider`: Gerenciamento de estado
- `http`: Comunicação com a API
- `connectivity_plus`: Verificação de conexão
- `intl`: Formatação de valores monetários



"# AtividadeFlutter" 
"# AtividadeFlutter" 
