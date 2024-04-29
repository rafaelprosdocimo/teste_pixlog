# translation_data

This project is a Flutter front-end application for managing translation resources. It includes features for fetching data from an HTTP API, caching and storing data using SQLite, and displaying data in a list view with filtering options.


## Getting Started

1. Clone repository
2. flutter pub get

## Dependancies:

- http
- sqflite
- path
- path_provider
- flutter_riverpod
- riverpod_annotation

# Dev Dependancies:

- flutter_test
- flutter_lints
- riverpod_generator
- build_runner
- custom_lint
- riverpod_lint

## Features:

1. Front-end: Lista de recursos, Input de texto para filtragem, Botões
2. Requisição GET http
3. Cache and store Data por meio de requisição
4. Visualização dos dados: Dados são renderizados na lista a partir da tabela no banco de dados.

## Usage:

A feature de filtro e pesquisa não foi implementada.

- Para a visualização dos dados é necessário que o usuário entre no aplicativo e pressione o botão de refresh. -> é onde a aplicação vai fazer a requisição e salvar no cache.

- Devido a uma falta de responsividade é necessário reiniciar a aplicação para que os dados sejam construidos por FutureBuilder.

- Ao reiniciar a aplicação ela automaticamente puxa os dados contidos no cache e renderiza os itens. 


! Ao clicar em refresh novamente ele limpa os dados na aplicação e faz outra requisição para obter dados novos. Porém a falta de responsividade requer que o usuário feche e abra o aplicativo para visualizar os novos dadados.


## Files:

Lib
|- main
|- post
|
|- pages
|   |- home
|
|- database
|   |-database_service
|   |- resource_translation
|
|- model
    |-translation_model


## Referencias:

- Flutter Networking Cookbook: [Link](https://docs.flutter.dev/cookbook/networking/fetch-data)
- Flutter FutureBuilder Widget: [Link](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- Flutter Persistence with SQLite: [Link](https://docs.flutter.dev/cookbook/persistence/sqlite)
- Riverpod Package: [Link](https://pub.dev/packages/riverpod)
