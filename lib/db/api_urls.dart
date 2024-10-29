class ApiUrl {
  String pokemonListApi({required int page, required int limit}) =>
      'https://api.pokemontcg.io/v2/cards?page=$page&pageSize=$limit';

  String pokemonSearchApi({required String query}) =>
      "https://api.pokemontcg.io/v2/cards?q=set.name:$query";
}
