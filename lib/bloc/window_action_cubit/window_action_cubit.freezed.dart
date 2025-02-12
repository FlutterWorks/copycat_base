// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'window_action_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WindowActionState {
  AppView get view => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppView view, bool loading) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppView view, bool loading)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppView view, bool loading)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WindowActionLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WindowActionLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WindowActionLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of WindowActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WindowActionStateCopyWith<WindowActionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindowActionStateCopyWith<$Res> {
  factory $WindowActionStateCopyWith(
          WindowActionState value, $Res Function(WindowActionState) then) =
      _$WindowActionStateCopyWithImpl<$Res, WindowActionState>;
  @useResult
  $Res call({AppView view, bool loading});
}

/// @nodoc
class _$WindowActionStateCopyWithImpl<$Res, $Val extends WindowActionState>
    implements $WindowActionStateCopyWith<$Res> {
  _$WindowActionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WindowActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? view = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as AppView,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WindowActionLoadedImplCopyWith<$Res>
    implements $WindowActionStateCopyWith<$Res> {
  factory _$$WindowActionLoadedImplCopyWith(_$WindowActionLoadedImpl value,
          $Res Function(_$WindowActionLoadedImpl) then) =
      __$$WindowActionLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppView view, bool loading});
}

/// @nodoc
class __$$WindowActionLoadedImplCopyWithImpl<$Res>
    extends _$WindowActionStateCopyWithImpl<$Res, _$WindowActionLoadedImpl>
    implements _$$WindowActionLoadedImplCopyWith<$Res> {
  __$$WindowActionLoadedImplCopyWithImpl(_$WindowActionLoadedImpl _value,
      $Res Function(_$WindowActionLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WindowActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? view = null,
    Object? loading = null,
  }) {
    return _then(_$WindowActionLoadedImpl(
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as AppView,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WindowActionLoadedImpl
    with DiagnosticableTreeMixin
    implements WindowActionLoaded {
  const _$WindowActionLoadedImpl(
      {this.view = AppView.windowed, this.loading = true});

  @override
  @JsonKey()
  final AppView view;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WindowActionState.loaded(view: $view, loading: $loading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WindowActionState.loaded'))
      ..add(DiagnosticsProperty('view', view))
      ..add(DiagnosticsProperty('loading', loading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WindowActionLoadedImpl &&
            (identical(other.view, view) || other.view == view) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, view, loading);

  /// Create a copy of WindowActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WindowActionLoadedImplCopyWith<_$WindowActionLoadedImpl> get copyWith =>
      __$$WindowActionLoadedImplCopyWithImpl<_$WindowActionLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppView view, bool loading) loaded,
  }) {
    return loaded(view, loading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppView view, bool loading)? loaded,
  }) {
    return loaded?.call(view, loading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppView view, bool loading)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(view, loading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WindowActionLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WindowActionLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WindowActionLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WindowActionLoaded implements WindowActionState {
  const factory WindowActionLoaded({final AppView view, final bool loading}) =
      _$WindowActionLoadedImpl;

  @override
  AppView get view;
  @override
  bool get loading;

  /// Create a copy of WindowActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WindowActionLoadedImplCopyWith<_$WindowActionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
