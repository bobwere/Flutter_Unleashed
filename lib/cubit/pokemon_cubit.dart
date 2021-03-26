import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_unleashed/common/constants.dart';
import 'package:flutter_unleashed/data/model/pokemon.dart';
import 'package:flutter_unleashed/data/pokemon_json.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sortedmap/sortedmap.dart';

part 'pokemon_state.dart';
part 'pokemon_cubit.freezed.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit(this._pref) : super(PokemonState.initial());

  final SharedPreferences _pref;

  Map<String, String> _dictionary = {
    '34': 'thirty-four',
    '90': 'ninety',
    '91': 'ninety-one',
    '21': 'twenty-one',
    '61': 'sixty-one',
    '9': 'nine',
    '2': 'two',
    '6': 'six',
    '3': 'three',
    '8': 'eight',
    '80': 'eighty',
    '81': 'eighty-one',
    'Ninety-Nine': '99',
    'nine-hundred': '900',
  };

  //function to sort the dictionary by their numeric keys
  Map<int, String> _sortNumericKeyyedMap(Map<String, String> dictionary) {
    Map<int, String> numericMap = new SortedMap(Ordering.byKey());

    //regex expression to filter dictionary values
    RegExp _numeric = RegExp(r'^-?[0-9]+$');

    //filter dictionary to get numeric key entries only
    Map<String, String> numericKeyMap = Map.from(dictionary)
      ..removeWhere((k, v) => !_numeric.hasMatch(k));

    //convert key from string value to int value for sorting
    Map<int, String> formattedKeyMap =
        numericKeyMap.map((key, value) => MapEntry(int.tryParse(key), value));

    //add formattedKeyMap to a SortMap to order by key in ascending manner
    numericMap.addAll(formattedKeyMap);

    return numericMap;
  }

  //function to sort the dictionary by their alpha keys
  Map<String, int> _sortAlphaKeyyedMap(Map<String, String> dictionary) {
    Map<String, int> alphaMap = new SortedMap(Ordering.byValue());

    //regex expression to filter dictionary values
    RegExp _numeric = RegExp(r'^-?[0-9]+$');

    //filter dictionary to get alpha key entries only
    Map<String, String> numericKeyMap = Map.from(dictionary)
      ..removeWhere((k, v) => _numeric.hasMatch(k));

    //convert value from each entry from string to int for sorting
    Map<String, int> formattedValueMap =
        numericKeyMap.map((key, value) => MapEntry(key, int.tryParse(value)));

    //add formattedValueMap to a SortMap to order by value in ascending manner
    alphaMap.addAll(formattedValueMap);

    return alphaMap;
  }

  List<Pokemon> _getAllPokemons(sortMap, List<Pokemon> pokemonData) {
    List<Pokemon> pokemons = [];

    sortMap.forEach((key, value) {
      var foundData = pokemonData.where((pokemon) => pokemon.key == key);
      pokemons.addAll(foundData);
    });

    return pokemons;
  }

  List<Pokemon> _getFavouritePokemons(List<Pokemon> pokemonData) {
    List<Pokemon> favouritepokemons = [];

    List<String> pokemonNames = _pref.getStringList(MY_FAVOURITES) ?? [];

    pokemonNames.forEach((name) {
      var foundData = pokemonData.where((pokemon) => pokemon.name == name);
      favouritepokemons.addAll(foundData);
    });

    return favouritepokemons;
  }

  void unsortedDictionary() {
    final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

    List<Pokemon> pokemons = [];

    RegExp _numeric = RegExp(r'^-?[0-9]+$');

    _dictionary.forEach((key, value) {
      if (_numeric.hasMatch(key)) {
        var foundData =
            pokemonData.where((pokemon) => pokemon.key == int.tryParse(key));
        pokemons.addAll(foundData);
      } else {
        var foundData = pokemonData.where((pokemon) => pokemon.key == key);
        pokemons.addAll(foundData);
      }
    });

    emit(state.copyWith.call(pokemons: pokemons));
  }

  void sortByNumericKey() {
    final sortMap = _sortNumericKeyyedMap(_dictionary);

    final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

    final pokemons = _getAllPokemons(sortMap, pokemonData);

    emit(state.copyWith.call(pokemons: pokemons));
  }

  void sortByAlphaKey() {
    final sortMap = _sortAlphaKeyyedMap(_dictionary);

    final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

    final pokemons = _getAllPokemons(sortMap, pokemonData);

    emit(state.copyWith.call(pokemons: pokemons));
  }

  void getFavourites() {
    final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

    final favouritepokemons = _getFavouritePokemons(pokemonData);

    emit(state.copyWith.call(favourites: favouritepokemons));
  }

  void addToFavorites(String name) async {
    emit(
      state.copyWith.call(
        actionSuccess: false,
        errorMessage: '',
        successMessage: '',
      ),
    );
    final savedFavourites = _pref.getStringList(MY_FAVOURITES) ?? [];

    final currentUser = _pref.getString(USER_NAME) ?? '';

    bool alreadySaved = savedFavourites.contains(name);

    if (currentUser.isEmpty) {
      emit(state.copyWith.call(
          errorMessage: 'Kindly create a user profile to access this feature'));
    } else if (alreadySaved) {
      emit(state.copyWith
          .call(errorMessage: 'You have already saved this pokemon!'));
    } else {
      savedFavourites.add(name);

      await _pref.setStringList(MY_FAVOURITES, savedFavourites);

      final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

      final favouritepokemons = _getFavouritePokemons(pokemonData);

      emit(
        state.copyWith.call(
            favourites: favouritepokemons,
            actionSuccess: true,
            successMessage:
                '$name has been added to your favourites successfully'),
      );
    }
  }

  void deleteFavorites(String name) async {
    emit(
      state.copyWith.call(
        actionSuccess: false,
        errorMessage: '',
        successMessage: '',
      ),
    );

    List<String> savedFavourites = _pref.getStringList(MY_FAVOURITES) ?? [];

    savedFavourites.remove(name);

    await _pref.setStringList(MY_FAVOURITES, savedFavourites);

    final pokemonData = pokemonFromJson(jsonEncode(pokemonJson));

    final favouritepokemons = _getFavouritePokemons(pokemonData);

    emit(
      state.copyWith.call(
        favourites: favouritepokemons,
        actionSuccess: true,
        successMessage:
            '$name has been deleted from your favourites successfully',
      ),
    );
  }
}
