// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_prefs.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetBookPrefsCollection on Isar {
  IsarCollection<int, BookPrefs> get bookPrefs => this.collection();
}

const BookPrefsSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'BookPrefs',
    idName: 'libItemId',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'speed',
        type: IsarType.double,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, BookPrefs>(
    serialize: serializeBookPrefs,
    deserialize: deserializeBookPrefs,
    deserializeProperty: deserializeBookPrefsProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeBookPrefs(IsarWriter writer, BookPrefs object) {
  IsarCore.writeDouble(writer, 1, object.speed ?? double.nan);
  return object.libItemId;
}

@isarProtected
BookPrefs deserializeBookPrefs(IsarReader reader) {
  final int _libItemId;
  _libItemId = IsarCore.readId(reader);
  final double? _speed;
  {
    final value = IsarCore.readDouble(reader, 1);
    if (value.isNaN) {
      _speed = null;
    } else {
      _speed = value;
    }
  }
  final object = BookPrefs(
    libItemId: _libItemId,
    speed: _speed,
  );
  return object;
}

@isarProtected
dynamic deserializeBookPrefsProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      {
        final value = IsarCore.readDouble(reader, 1);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BookPrefsUpdate {
  bool call({
    required int libItemId,
    double? speed,
  });
}

class _BookPrefsUpdateImpl implements _BookPrefsUpdate {
  const _BookPrefsUpdateImpl(this.collection);

  final IsarCollection<int, BookPrefs> collection;

  @override
  bool call({
    required int libItemId,
    Object? speed = ignore,
  }) {
    return collection.updateProperties([
          libItemId
        ], {
          if (speed != ignore) 1: speed as double?,
        }) >
        0;
  }
}

sealed class _BookPrefsUpdateAll {
  int call({
    required List<int> libItemId,
    double? speed,
  });
}

class _BookPrefsUpdateAllImpl implements _BookPrefsUpdateAll {
  const _BookPrefsUpdateAllImpl(this.collection);

  final IsarCollection<int, BookPrefs> collection;

  @override
  int call({
    required List<int> libItemId,
    Object? speed = ignore,
  }) {
    return collection.updateProperties(libItemId, {
      if (speed != ignore) 1: speed as double?,
    });
  }
}

extension BookPrefsUpdate on IsarCollection<int, BookPrefs> {
  _BookPrefsUpdate get update => _BookPrefsUpdateImpl(this);

  _BookPrefsUpdateAll get updateAll => _BookPrefsUpdateAllImpl(this);
}

sealed class _BookPrefsQueryUpdate {
  int call({
    double? speed,
  });
}

class _BookPrefsQueryUpdateImpl implements _BookPrefsQueryUpdate {
  const _BookPrefsQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<BookPrefs> query;
  final int? limit;

  @override
  int call({
    Object? speed = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (speed != ignore) 1: speed as double?,
    });
  }
}

extension BookPrefsQueryUpdate on IsarQuery<BookPrefs> {
  _BookPrefsQueryUpdate get updateFirst =>
      _BookPrefsQueryUpdateImpl(this, limit: 1);

  _BookPrefsQueryUpdate get updateAll => _BookPrefsQueryUpdateImpl(this);
}

class _BookPrefsQueryBuilderUpdateImpl implements _BookPrefsQueryUpdate {
  const _BookPrefsQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<BookPrefs, BookPrefs, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? speed = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (speed != ignore) 1: speed as double?,
      });
    } finally {
      q.close();
    }
  }
}

extension BookPrefsQueryBuilderUpdate
    on QueryBuilder<BookPrefs, BookPrefs, QOperations> {
  _BookPrefsQueryUpdate get updateFirst =>
      _BookPrefsQueryBuilderUpdateImpl(this, limit: 1);

  _BookPrefsQueryUpdate get updateAll => _BookPrefsQueryBuilderUpdateImpl(this);
}

extension BookPrefsQueryFilter
    on QueryBuilder<BookPrefs, BookPrefs, QFilterCondition> {
  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> libItemIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition>
      libItemIdGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition>
      libItemIdGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> libItemIdLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition>
      libItemIdLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> libItemIdBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition>
      speedGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition>
      speedLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterFilterCondition> speedBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }
}

extension BookPrefsQueryObject
    on QueryBuilder<BookPrefs, BookPrefs, QFilterCondition> {}

extension BookPrefsQuerySortBy on QueryBuilder<BookPrefs, BookPrefs, QSortBy> {
  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> sortByLibItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> sortByLibItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> sortBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> sortBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }
}

extension BookPrefsQuerySortThenBy
    on QueryBuilder<BookPrefs, BookPrefs, QSortThenBy> {
  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> thenByLibItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> thenByLibItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> thenBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<BookPrefs, BookPrefs, QAfterSortBy> thenBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }
}

extension BookPrefsQueryWhereDistinct
    on QueryBuilder<BookPrefs, BookPrefs, QDistinct> {
  QueryBuilder<BookPrefs, BookPrefs, QAfterDistinct> distinctBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }
}

extension BookPrefsQueryProperty1
    on QueryBuilder<BookPrefs, BookPrefs, QProperty> {
  QueryBuilder<BookPrefs, int, QAfterProperty> libItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BookPrefs, double?, QAfterProperty> speedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension BookPrefsQueryProperty2<R>
    on QueryBuilder<BookPrefs, R, QAfterProperty> {
  QueryBuilder<BookPrefs, (R, int), QAfterProperty> libItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BookPrefs, (R, double?), QAfterProperty> speedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension BookPrefsQueryProperty3<R1, R2>
    on QueryBuilder<BookPrefs, (R1, R2), QAfterProperty> {
  QueryBuilder<BookPrefs, (R1, R2, int), QOperations> libItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BookPrefs, (R1, R2, double?), QOperations> speedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}
