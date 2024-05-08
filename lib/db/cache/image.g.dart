// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas/image.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetImageCollection on Isar {
  IsarCollection<int, Image> get images => this.collection();
}

const ImageSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Image',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'thumbnailPath',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'imagePath',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lastSaved',
        type: IsarType.dateTime,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, Image>(
    serialize: serializeImage,
    deserialize: deserializeImage,
    deserializeProperty: deserializeImageProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeImage(IsarWriter writer, Image object) {
  {
    final value = object.thumbnailPath;
    if (value == null) {
      IsarCore.writeNull(writer, 1);
    } else {
      IsarCore.writeString(writer, 1, value);
    }
  }
  {
    final value = object.imagePath;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  IsarCore.writeLong(
      writer, 3, object.lastSaved.toUtc().microsecondsSinceEpoch);
  return object.id;
}

@isarProtected
Image deserializeImage(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String? _thumbnailPath;
  _thumbnailPath = IsarCore.readString(reader, 1);
  final String? _imagePath;
  _imagePath = IsarCore.readString(reader, 2);
  final object = Image(
    id: _id,
    thumbnailPath: _thumbnailPath,
    imagePath: _imagePath,
  );
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      object.lastSaved =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      object.lastSaved =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeImageProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1);
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ImageUpdate {
  bool call({
    required int id,
    String? thumbnailPath,
    String? imagePath,
    DateTime? lastSaved,
  });
}

class _ImageUpdateImpl implements _ImageUpdate {
  const _ImageUpdateImpl(this.collection);

  final IsarCollection<int, Image> collection;

  @override
  bool call({
    required int id,
    Object? thumbnailPath = ignore,
    Object? imagePath = ignore,
    Object? lastSaved = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (thumbnailPath != ignore) 1: thumbnailPath as String?,
          if (imagePath != ignore) 2: imagePath as String?,
          if (lastSaved != ignore) 3: lastSaved as DateTime?,
        }) >
        0;
  }
}

sealed class _ImageUpdateAll {
  int call({
    required List<int> id,
    String? thumbnailPath,
    String? imagePath,
    DateTime? lastSaved,
  });
}

class _ImageUpdateAllImpl implements _ImageUpdateAll {
  const _ImageUpdateAllImpl(this.collection);

  final IsarCollection<int, Image> collection;

  @override
  int call({
    required List<int> id,
    Object? thumbnailPath = ignore,
    Object? imagePath = ignore,
    Object? lastSaved = ignore,
  }) {
    return collection.updateProperties(id, {
      if (thumbnailPath != ignore) 1: thumbnailPath as String?,
      if (imagePath != ignore) 2: imagePath as String?,
      if (lastSaved != ignore) 3: lastSaved as DateTime?,
    });
  }
}

extension ImageUpdate on IsarCollection<int, Image> {
  _ImageUpdate get update => _ImageUpdateImpl(this);

  _ImageUpdateAll get updateAll => _ImageUpdateAllImpl(this);
}

sealed class _ImageQueryUpdate {
  int call({
    String? thumbnailPath,
    String? imagePath,
    DateTime? lastSaved,
  });
}

class _ImageQueryUpdateImpl implements _ImageQueryUpdate {
  const _ImageQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Image> query;
  final int? limit;

  @override
  int call({
    Object? thumbnailPath = ignore,
    Object? imagePath = ignore,
    Object? lastSaved = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (thumbnailPath != ignore) 1: thumbnailPath as String?,
      if (imagePath != ignore) 2: imagePath as String?,
      if (lastSaved != ignore) 3: lastSaved as DateTime?,
    });
  }
}

extension ImageQueryUpdate on IsarQuery<Image> {
  _ImageQueryUpdate get updateFirst => _ImageQueryUpdateImpl(this, limit: 1);

  _ImageQueryUpdate get updateAll => _ImageQueryUpdateImpl(this);
}

class _ImageQueryBuilderUpdateImpl implements _ImageQueryUpdate {
  const _ImageQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Image, Image, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? thumbnailPath = ignore,
    Object? imagePath = ignore,
    Object? lastSaved = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (thumbnailPath != ignore) 1: thumbnailPath as String?,
        if (imagePath != ignore) 2: imagePath as String?,
        if (lastSaved != ignore) 3: lastSaved as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension ImageQueryBuilderUpdate on QueryBuilder<Image, Image, QOperations> {
  _ImageQueryUpdate get updateFirst =>
      _ImageQueryBuilderUpdateImpl(this, limit: 1);

  _ImageQueryUpdate get updateAll => _ImageQueryBuilderUpdateImpl(this);
}

extension ImageQueryFilter on QueryBuilder<Image, Image, QFilterCondition> {
  QueryBuilder<Image, Image, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idGreaterThanOrEqualTo(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition>
      thumbnailPathGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition>
      thumbnailPathLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> thumbnailPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition>
      imagePathGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> lastSavedEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> lastSavedGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition>
      lastSavedGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> lastSavedLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> lastSavedLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> lastSavedBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension ImageQueryObject on QueryBuilder<Image, Image, QFilterCondition> {}

extension ImageQuerySortBy on QueryBuilder<Image, Image, QSortBy> {
  QueryBuilder<Image, Image, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByThumbnailPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByThumbnailPathDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByImagePathDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByLastSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByLastSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ImageQuerySortThenBy on QueryBuilder<Image, Image, QSortThenBy> {
  QueryBuilder<Image, Image, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByThumbnailPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByThumbnailPathDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByImagePathDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByLastSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByLastSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ImageQueryWhereDistinct on QueryBuilder<Image, Image, QDistinct> {
  QueryBuilder<Image, Image, QAfterDistinct> distinctByThumbnailPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QAfterDistinct> distinctByLastSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension ImageQueryProperty1 on QueryBuilder<Image, Image, QProperty> {
  QueryBuilder<Image, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Image, String?, QAfterProperty> thumbnailPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Image, String?, QAfterProperty> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Image, DateTime, QAfterProperty> lastSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ImageQueryProperty2<R> on QueryBuilder<Image, R, QAfterProperty> {
  QueryBuilder<Image, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Image, (R, String?), QAfterProperty> thumbnailPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Image, (R, String?), QAfterProperty> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Image, (R, DateTime), QAfterProperty> lastSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ImageQueryProperty3<R1, R2>
    on QueryBuilder<Image, (R1, R2), QAfterProperty> {
  QueryBuilder<Image, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Image, (R1, R2, String?), QOperations> thumbnailPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Image, (R1, R2, String?), QOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Image, (R1, R2, DateTime), QOperations> lastSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
