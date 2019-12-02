import 'package:flutter/material.dart';

/// A function that should notify listeners, if any.
typedef UpdateNotifier<T> = bool Function(T previous, T current);

/// Returns the type [T].
Type _typeOf<T>() => T;

class ComponentInherited<T> extends InheritedWidget {
  /// Create a ComponentInherited widget.
  /// 
  /// The [child] argument must not be null.
  ComponentInherited({
    Key key,
    @required Widget child,
    this.updateNotifier,
    @required this.value,
  }): assert(child != null),
      super(key: key, child: child);
  
  final T value;
  final UpdateNotifier<T> updateNotifier;

  /// Notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(ComponentInherited<T> old) {
    if (this.updateNotifier != null) {
      return this.updateNotifier(old.value, this.value);
    }
    return old.value != this.value;
  }
}

class Component<T> extends StatefulWidget {
  /// Create a Component widget.
  Component({
    Key key,
    Disposer<T> disposer,
    @required Creator<T> creator,
    @required Widget child,
  }): this.standard(
    key: key,
    updateNotifier: null,
    delegate: BuilderValueDelegate<T>(creator: creator, disposer: disposer),
    child: child,
  );

  Component.value({
    Key key,
    @required UpdateNotifier<T> updateNotifier,
    @required T value,
    @required Widget child,
  }): this.standard(
    key: key,
    updateNotifier: updateNotifier,
    delegate: SingleValueDelegate<T>(value),
    child: child,
  );

  Component.standard({
    Key key,
    this.updateNotifier,
    @required this.delegate,
    @required this.child,
  }): assert(child != null),
      super(key: key);

  final ValueDelegate<T> delegate;
  final UpdateNotifier<T> updateNotifier;
  final Widget child;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<Component<T>> createState() => _ComponentState<T>();

  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<ComponentInherited<T>>();
    final component = listen
        ? context.inheritFromWidgetOfExactType(type) as ComponentInherited<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)
            as ComponentInherited<T>;
    if (component == null) {
      throw ComponentNotFound(T, context.widget.runtimeType);
    }

    return component.value;
  }
}

class _ComponentState<T> extends State<Component<T>> {
  ValueDelegate<T> delegate;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.delegate = this.widget.delegate;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(Component old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.delegate.dispose(this.context);
    super.dispose();
  }

  /// Build the Component widget with state.
  @override
  Widget build(BuildContext context) {
    return ComponentInherited<T>(
      value: this.delegate.get(context),
      child: this.widget.child,
      updateNotifier: this.widget.updateNotifier,
    );
  }
}

class ComponentNotFound extends Error {
  ComponentNotFound(
    this.component,
    this.widget,
  );

  final Type component;
  final Type widget;

  @override
  String toString() {
    return '';
  }
}

/// A function that creates an object of type [T].
typedef Creator<T> = T Function(BuildContext context);
/// A function that disposes an object of type [T].
typedef Disposer<T> = void Function(BuildContext context, T component);

/// Provides a value on request.
abstract class ValueDelegate<T> {
  T get(BuildContext context);
  void dispose(BuildContext context);
}

/// Provides a value for value request each time,
/// if value not available will obtained from [Creator<T>].
class BuilderValueDelegate<T> with ValueDelegate<T> {
  BuilderValueDelegate({
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
class SingleValueDelegate<T> extends ValueDelegate<T> {
  SingleValueDelegate(T value): this._value = value;

  final T _value;
  @override
  T get(BuildContext context) {
    return this._value;
  }

  @override
  void dispose(BuildContext context) {
  }
}

/// Obtain [Component<T>] from its ancestors and pass its value to [builder].
class Consumer<T> extends StatelessWidget {
  /// Create a Consumer widget.
  /// 
  /// The [builder] argument must not be null.
  /// The `builder` argument used to build widget.
  Consumer({
    Key key,
    @required this.builder,
  }): assert(builder != null),
      super(key: key);
  
  final Widget Function(BuildContext context, T component) builder;
  /// Build the Consumer widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<T>(context);
    return this.builder(context, component);
  }
}
