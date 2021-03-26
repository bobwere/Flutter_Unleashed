part of 'pokemon_cubit.dart';

@freezed
abstract class PokemonState with _$PokemonState {
  const factory PokemonState({
    @required List<Pokemon> pokemons,
    @required List<Pokemon> favourites,
    @required bool actionSuccess,
    @required String errorMessage,
    @required String successMessage,
  }) = _LoadedPokemons;

  factory PokemonState.initial() => PokemonState(
      pokemons: [],
      favourites: [],
      actionSuccess: false,
      errorMessage: '',
      successMessage: '');
}
