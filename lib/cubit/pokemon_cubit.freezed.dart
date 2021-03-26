// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pokemon_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PokemonStateTearOff {
  const _$PokemonStateTearOff();

// ignore: unused_element
  _LoadedPokemons call(
      {@required List<Pokemon> pokemons,
      @required List<Pokemon> favourites,
      @required bool actionSuccess,
      @required String errorMessage,
      @required String successMessage}) {
    return _LoadedPokemons(
      pokemons: pokemons,
      favourites: favourites,
      actionSuccess: actionSuccess,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PokemonState = _$PokemonStateTearOff();

/// @nodoc
mixin _$PokemonState {
  List<Pokemon> get pokemons;
  List<Pokemon> get favourites;
  bool get actionSuccess;
  String get errorMessage;
  String get successMessage;

  @JsonKey(ignore: true)
  $PokemonStateCopyWith<PokemonState> get copyWith;
}

/// @nodoc
abstract class $PokemonStateCopyWith<$Res> {
  factory $PokemonStateCopyWith(
          PokemonState value, $Res Function(PokemonState) then) =
      _$PokemonStateCopyWithImpl<$Res>;
  $Res call(
      {List<Pokemon> pokemons,
      List<Pokemon> favourites,
      bool actionSuccess,
      String errorMessage,
      String successMessage});
}

/// @nodoc
class _$PokemonStateCopyWithImpl<$Res> implements $PokemonStateCopyWith<$Res> {
  _$PokemonStateCopyWithImpl(this._value, this._then);

  final PokemonState _value;
  // ignore: unused_field
  final $Res Function(PokemonState) _then;

  @override
  $Res call({
    Object pokemons = freezed,
    Object favourites = freezed,
    Object actionSuccess = freezed,
    Object errorMessage = freezed,
    Object successMessage = freezed,
  }) {
    return _then(_value.copyWith(
      pokemons:
          pokemons == freezed ? _value.pokemons : pokemons as List<Pokemon>,
      favourites: favourites == freezed
          ? _value.favourites
          : favourites as List<Pokemon>,
      actionSuccess: actionSuccess == freezed
          ? _value.actionSuccess
          : actionSuccess as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage as String,
      successMessage: successMessage == freezed
          ? _value.successMessage
          : successMessage as String,
    ));
  }
}

/// @nodoc
abstract class _$LoadedPokemonsCopyWith<$Res>
    implements $PokemonStateCopyWith<$Res> {
  factory _$LoadedPokemonsCopyWith(
          _LoadedPokemons value, $Res Function(_LoadedPokemons) then) =
      __$LoadedPokemonsCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Pokemon> pokemons,
      List<Pokemon> favourites,
      bool actionSuccess,
      String errorMessage,
      String successMessage});
}

/// @nodoc
class __$LoadedPokemonsCopyWithImpl<$Res>
    extends _$PokemonStateCopyWithImpl<$Res>
    implements _$LoadedPokemonsCopyWith<$Res> {
  __$LoadedPokemonsCopyWithImpl(
      _LoadedPokemons _value, $Res Function(_LoadedPokemons) _then)
      : super(_value, (v) => _then(v as _LoadedPokemons));

  @override
  _LoadedPokemons get _value => super._value as _LoadedPokemons;

  @override
  $Res call({
    Object pokemons = freezed,
    Object favourites = freezed,
    Object actionSuccess = freezed,
    Object errorMessage = freezed,
    Object successMessage = freezed,
  }) {
    return _then(_LoadedPokemons(
      pokemons:
          pokemons == freezed ? _value.pokemons : pokemons as List<Pokemon>,
      favourites: favourites == freezed
          ? _value.favourites
          : favourites as List<Pokemon>,
      actionSuccess: actionSuccess == freezed
          ? _value.actionSuccess
          : actionSuccess as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage as String,
      successMessage: successMessage == freezed
          ? _value.successMessage
          : successMessage as String,
    ));
  }
}

/// @nodoc
class _$_LoadedPokemons implements _LoadedPokemons {
  const _$_LoadedPokemons(
      {@required this.pokemons,
      @required this.favourites,
      @required this.actionSuccess,
      @required this.errorMessage,
      @required this.successMessage})
      : assert(pokemons != null),
        assert(favourites != null),
        assert(actionSuccess != null),
        assert(errorMessage != null),
        assert(successMessage != null);

  @override
  final List<Pokemon> pokemons;
  @override
  final List<Pokemon> favourites;
  @override
  final bool actionSuccess;
  @override
  final String errorMessage;
  @override
  final String successMessage;

  @override
  String toString() {
    return 'PokemonState(pokemons: $pokemons, favourites: $favourites, actionSuccess: $actionSuccess, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoadedPokemons &&
            (identical(other.pokemons, pokemons) ||
                const DeepCollectionEquality()
                    .equals(other.pokemons, pokemons)) &&
            (identical(other.favourites, favourites) ||
                const DeepCollectionEquality()
                    .equals(other.favourites, favourites)) &&
            (identical(other.actionSuccess, actionSuccess) ||
                const DeepCollectionEquality()
                    .equals(other.actionSuccess, actionSuccess)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.successMessage, successMessage) ||
                const DeepCollectionEquality()
                    .equals(other.successMessage, successMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pokemons) ^
      const DeepCollectionEquality().hash(favourites) ^
      const DeepCollectionEquality().hash(actionSuccess) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(successMessage);

  @JsonKey(ignore: true)
  @override
  _$LoadedPokemonsCopyWith<_LoadedPokemons> get copyWith =>
      __$LoadedPokemonsCopyWithImpl<_LoadedPokemons>(this, _$identity);
}

abstract class _LoadedPokemons implements PokemonState {
  const factory _LoadedPokemons(
      {@required List<Pokemon> pokemons,
      @required List<Pokemon> favourites,
      @required bool actionSuccess,
      @required String errorMessage,
      @required String successMessage}) = _$_LoadedPokemons;

  @override
  List<Pokemon> get pokemons;
  @override
  List<Pokemon> get favourites;
  @override
  bool get actionSuccess;
  @override
  String get errorMessage;
  @override
  String get successMessage;
  @override
  @JsonKey(ignore: true)
  _$LoadedPokemonsCopyWith<_LoadedPokemons> get copyWith;
}
