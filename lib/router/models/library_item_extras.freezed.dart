// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_item_extras.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LibraryItemExtras {
  BookMinified? get book => throw _privateConstructorUsedError;
  String get heroTagSuffix => throw _privateConstructorUsedError;

  /// Create a copy of LibraryItemExtras
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LibraryItemExtrasCopyWith<LibraryItemExtras> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibraryItemExtrasCopyWith<$Res> {
  factory $LibraryItemExtrasCopyWith(
          LibraryItemExtras value, $Res Function(LibraryItemExtras) then) =
      _$LibraryItemExtrasCopyWithImpl<$Res, LibraryItemExtras>;
  @useResult
  $Res call({BookMinified? book, String heroTagSuffix});
}

/// @nodoc
class _$LibraryItemExtrasCopyWithImpl<$Res, $Val extends LibraryItemExtras>
    implements $LibraryItemExtrasCopyWith<$Res> {
  _$LibraryItemExtrasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LibraryItemExtras
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? heroTagSuffix = null,
  }) {
    return _then(_value.copyWith(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookMinified?,
      heroTagSuffix: null == heroTagSuffix
          ? _value.heroTagSuffix
          : heroTagSuffix // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibraryItemExtrasImplCopyWith<$Res>
    implements $LibraryItemExtrasCopyWith<$Res> {
  factory _$$LibraryItemExtrasImplCopyWith(_$LibraryItemExtrasImpl value,
          $Res Function(_$LibraryItemExtrasImpl) then) =
      __$$LibraryItemExtrasImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BookMinified? book, String heroTagSuffix});
}

/// @nodoc
class __$$LibraryItemExtrasImplCopyWithImpl<$Res>
    extends _$LibraryItemExtrasCopyWithImpl<$Res, _$LibraryItemExtrasImpl>
    implements _$$LibraryItemExtrasImplCopyWith<$Res> {
  __$$LibraryItemExtrasImplCopyWithImpl(_$LibraryItemExtrasImpl _value,
      $Res Function(_$LibraryItemExtrasImpl) _then)
      : super(_value, _then);

  /// Create a copy of LibraryItemExtras
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? heroTagSuffix = null,
  }) {
    return _then(_$LibraryItemExtrasImpl(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookMinified?,
      heroTagSuffix: null == heroTagSuffix
          ? _value.heroTagSuffix
          : heroTagSuffix // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LibraryItemExtrasImpl implements _LibraryItemExtras {
  const _$LibraryItemExtrasImpl({this.book, this.heroTagSuffix = ''});

  @override
  final BookMinified? book;
  @override
  @JsonKey()
  final String heroTagSuffix;

  @override
  String toString() {
    return 'LibraryItemExtras(book: $book, heroTagSuffix: $heroTagSuffix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibraryItemExtrasImpl &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.heroTagSuffix, heroTagSuffix) ||
                other.heroTagSuffix == heroTagSuffix));
  }

  @override
  int get hashCode => Object.hash(runtimeType, book, heroTagSuffix);

  /// Create a copy of LibraryItemExtras
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LibraryItemExtrasImplCopyWith<_$LibraryItemExtrasImpl> get copyWith =>
      __$$LibraryItemExtrasImplCopyWithImpl<_$LibraryItemExtrasImpl>(
          this, _$identity);
}

abstract class _LibraryItemExtras implements LibraryItemExtras {
  const factory _LibraryItemExtras(
      {final BookMinified? book,
      final String heroTagSuffix}) = _$LibraryItemExtrasImpl;

  @override
  BookMinified? get book;
  @override
  String get heroTagSuffix;

  /// Create a copy of LibraryItemExtras
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LibraryItemExtrasImplCopyWith<_$LibraryItemExtrasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
