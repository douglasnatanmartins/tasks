part of '../provider.dart';

/// A function that creates an object of type [T].
typedef Creator<T> = T Function(BuildContext context);

/// A function that disposes an object of type [T].
typedef Disposer<T> = void Function(BuildContext context, T component);

/// Provides a value on request.
abstract class ComponentDelegate<T> {
  T get(BuildContext context);
  void dispose(BuildContext context);
}

/// Provides a value for value request each time,
/// if value not available will obtained from [Creator<T>].
class BuilderComponentDelegate<T> implements ComponentDelegate<T> {
  BuilderComponentDelegate({
    @required Creator<T> creator,
    Disposer<T> disposer,
  }): assert(creator != null),
      this._creator = creator,
      this._disposer = disposer;

  final Creator<T> _creator;
  final Disposer<T> _disposer;

  T _value;
  @override
  T get(BuildContext context) {
    if (this._value == null) {
      this._value = this._creator(context);
    }
    return this._value;
  }

  @override
  void dispose(BuildContext context) {
    if (this._disposer != null) {
      this._disposer(context, this._value);
    }
  }
}

/// Contains a value which will never be disposed.
class SingleComponentDelegate<T> implements ComponentDelegate<T> {
  SingleComponentDelegate(T value): this._value = value;

  final T _value;

  @override
  T get(BuildContext context) {
    return this._value;
  }

  @override
  void dispose(BuildContext context) {
  }
}
