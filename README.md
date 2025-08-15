# Rick & Morty API - Flutter

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-8A2BE2?style=for-the-badge)

A Flutter application that connects to the Rick & Morty API using Riverpod for state management.

## � Requirements

### For Local Development
- Flutter SDK (latest stable version)
- Dart SDK

### For Docker Deployment
- Docker Engine

## 🚀 Getting Started

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/SebasChips/API_flutter_riverpod.git
   cd API_flutter_riverpod

2. **Install dependencies**
   ```bash
   flutter pub get

3. **Run the application**
   ```bash
   flutter run -d web-server

4. **Access the application**
    Open your browser and navigate to the localhost address provided in the console output

### Docker Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/SebasChips/API_flutter_riverpod.git
   cd API_flutter_riverpod

2. **Create image**
   ```bash
   docker build -t rickmorty-api .

3. **Run the image**
   ```bash
   docker run --rm -it -p 8080:8080 rickmorty-api
   
4. **Open the application**
   Open your browser and navigate to: http://localhost:8080
