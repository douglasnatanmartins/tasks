import 'package:flutter/material.dart';

part 'provider/consumer.dart';
part 'provider/component_delegate.dart';

/// A function that should notify listeners, if any.
typedef UpdateNotifier<T> = bool Function(T previous, T current);

/// Returns the type [T].
Type _typeOf<T>() => T;

class ComponentProvider<T> extends InheritedWidget {
  /// Create a ComponentProvider widget.
  /// 
  /// The [child] argument must not be null.
  const ComponentProvider({
    Key key,
    @required Widget child,
    @required this.component,
    this.notifier,
  }): assert(child != null),
      super(key: key, child: child);
  
  final T component;
  final UpdateNotifier<T> notifier;

  /// Notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(ComponentProvider<T> old) {
    if (this.notifier != null) {
      return this.notifier(old.component, this.component);
    }

    return old.component != this.component;
  }
}

class Provider<T> extends StatefulWidget {
  /// Create a Provider widget.
  Provider({
    Key key,
    @required Widget child,
    @required Creator<T> creator,
    Disposer<T> disposer,
  }): this._(
    key: key,
    child: child,
    delegate: BuilderComponentDelegate<T>(
      creator: creator,
      disposer: disposer,
    ),
    notifier: null,
  );

  Provider.component({
    Key key,
    @required Widget child,
    @required T component,
    @required UpdateNotifier<T> notifier,
  }): this._(
    key: key,
    child: child,
    delegate: SingleComponentDelegate<T>(component),
    notifier: notifier,
  );

  Provider._({
    Key key,
    @required this.child,
    @required this.delegate,
    @required this.notifier,
  }): assert(child != null),
      assert(delegate != null),
      super(key: key);

  final Widget child;
  final ComponentDelegate<T> delegate;
  final UpdateNotifier<T> notifier;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<Provider<T>> createState() => _ProviderState<T>();

  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<ComponentProvider<T>>();
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as ComponentProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)
            as ComponentProvider<T>;

    if (provider == null) {
      throw ProviderNotFound(T, context.widget.runtimeType);
    }

    return provider.component;
  }
}

class _ProviderState<T> extends State<Provider<T>> {
  ComponentDelegate delegate;

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
  void didUpdateWidget(Provider old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.delegate.dispose(this.context);
    super.dispose();
  }

  /// Build the Provider widget with state.
  @override
  Widget build(BuildContext context) {
    return ComponentProvider<T>(
      component: this.delegate.get(context),
      child: this.widget.child,
      notifier: this.widget.notifier,
    );
  }
}

class ProviderNotFound extends Error {
  ProviderNotFound(
    this.component,
    this.widget,
  );

  final Type component;
  final Type widget;

  @override
  String toString() {
    return 'Error: Could not find the correct Provider<${this.component}> above this ${this.widget} Widget.';
  }
}
