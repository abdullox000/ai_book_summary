// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookSummaryModel {

 String? get summary; int? get rating; String? get author; String? get title; DateTime? get createdAt;
/// Create a copy of BookSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookSummaryModelCopyWith<BookSummaryModel> get copyWith => _$BookSummaryModelCopyWithImpl<BookSummaryModel>(this as BookSummaryModel, _$identity);

  /// Serializes this BookSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookSummaryModel&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.author, author) || other.author == author)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,rating,author,title,createdAt);

@override
String toString() {
  return 'BookSummaryModel(summary: $summary, rating: $rating, author: $author, title: $title, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookSummaryModelCopyWith<$Res>  {
  factory $BookSummaryModelCopyWith(BookSummaryModel value, $Res Function(BookSummaryModel) _then) = _$BookSummaryModelCopyWithImpl;
@useResult
$Res call({
 String? summary, int? rating, String? author, String? title, DateTime? createdAt
});




}
/// @nodoc
class _$BookSummaryModelCopyWithImpl<$Res>
    implements $BookSummaryModelCopyWith<$Res> {
  _$BookSummaryModelCopyWithImpl(this._self, this._then);

  final BookSummaryModel _self;
  final $Res Function(BookSummaryModel) _then;

/// Create a copy of BookSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,Object? rating = freezed,Object? author = freezed,Object? title = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookSummaryModel].
extension BookSummaryModelPatterns on BookSummaryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookSummaryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _BookSummaryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookSummaryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? summary,  int? rating,  String? author,  String? title,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookSummaryModel() when $default != null:
return $default(_that.summary,_that.rating,_that.author,_that.title,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? summary,  int? rating,  String? author,  String? title,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookSummaryModel():
return $default(_that.summary,_that.rating,_that.author,_that.title,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? summary,  int? rating,  String? author,  String? title,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookSummaryModel() when $default != null:
return $default(_that.summary,_that.rating,_that.author,_that.title,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookSummaryModel implements BookSummaryModel {
  const _BookSummaryModel({this.summary, this.rating, this.author, this.title, this.createdAt});
  factory _BookSummaryModel.fromJson(Map<String, dynamic> json) => _$BookSummaryModelFromJson(json);

@override final  String? summary;
@override final  int? rating;
@override final  String? author;
@override final  String? title;
@override final  DateTime? createdAt;

/// Create a copy of BookSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookSummaryModelCopyWith<_BookSummaryModel> get copyWith => __$BookSummaryModelCopyWithImpl<_BookSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookSummaryModel&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.author, author) || other.author == author)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,rating,author,title,createdAt);

@override
String toString() {
  return 'BookSummaryModel(summary: $summary, rating: $rating, author: $author, title: $title, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookSummaryModelCopyWith<$Res> implements $BookSummaryModelCopyWith<$Res> {
  factory _$BookSummaryModelCopyWith(_BookSummaryModel value, $Res Function(_BookSummaryModel) _then) = __$BookSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String? summary, int? rating, String? author, String? title, DateTime? createdAt
});




}
/// @nodoc
class __$BookSummaryModelCopyWithImpl<$Res>
    implements _$BookSummaryModelCopyWith<$Res> {
  __$BookSummaryModelCopyWithImpl(this._self, this._then);

  final _BookSummaryModel _self;
  final $Res Function(_BookSummaryModel) _then;

/// Create a copy of BookSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? rating = freezed,Object? author = freezed,Object? title = freezed,Object? createdAt = freezed,}) {
  return _then(_BookSummaryModel(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
