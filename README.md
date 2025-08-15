# API Rick&Morty
This a a Flutter project with the purpose of connecting to an API using the state management "Riverpod".

## Requirements
- SDK of Dart & flutter
## Requirements for exucution with Docker
- Docker

## Project ejecutation without Docker
1.- Clone this project: git clone https://github.com/SebasChips/API_flutter_riverpod
2.- Enter the projecy: cd API_flutter_riverpod
2.- Get the dependencies: flutter pub get
3.- Execute the web server: flutter run -d web-server
4.- Enter the URL localhost that past the command provided

## Project ejecutation with Docker
1.- Clone this project: git clone https://github.com/SebasChips/API_flutter_riverpod
2.- Enter the projecy: cd API_flutter_riverpod
3.- Build the docker image: docker build -t api_project . 
4.- Run the docker image: docker run --rm -it -p 8080:8080 api_project
5 .- Enter to http://127.0.0.1:8080/

