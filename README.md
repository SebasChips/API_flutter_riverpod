# Rick & Morty API - Flutter

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-8A2BE2?style=for-the-badge)

A Flutter application that connects to the Rick & Morty API using Riverpod for state management.

## 📋 Features

- Fetch and display characters from the Rick & Morty API
- Efficient state management with Riverpod
- Responsive design for multiple platforms
- Docker support for containerized deployment
- Clean architecture implementation

## � Requirements

### For Local Development
- Flutter SDK (latest stable version)
- Dart SDK
- Chrome browser (for web testing)

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

### Local Development

1. **Clone the repository**
   ```bash
   docker build -t rickmorty-api .

2. **Install dependencies**
   ```bash
   docker run --rm -it -p 8080:8080 rickmorty-api

3. **Run the application**
   Open your browser and navigate to: http://localhost:8080
