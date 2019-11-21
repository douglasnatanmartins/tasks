import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

/// The Component for Provider.
class Component<T> {
  /// Create a component.
  /// 
  /// The [onCreated] argument must not be null.
  /// The `onCreated` used to create the component instance.
  /// 
  /// The [onDispose] argument must not be null.
  Component({
    this.onCreated,
    this.onDispose,
  });

  final T Function() onCreated;
  final Function(T component) onDispose;

  /// Get the component type.
  Type get type => _typeOf<T>();
}

class Provider<P> extends StatefulWidget {
  /// Create a Provider widget.
  Provider({
    Key key,
    @required this.child,
    @required this.components,
  }): super(key: key);

  final Widget child;
  final List<Component> components;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<Provider<P>> createState() => _ProviderState<P>();

  static dynamic of<P>(BuildContext context, {Type component}) {
    final name = _typeOf<InheritedProvider<P>>();
    final InheritedProvider<P> provider = context.inheritFromWidgetOfExactType(name);
  
    if (provider == null) {
      return null;
    }

    if (component != null) {
      if (provider.components.containsKey(component)) {
        return provider.components[component];
      }
      return null;
    } else {
      return provider.components;
    }
  }
}

class _ProviderState<P> extends State<Provider<P>> {
  Map<Type, dynamic> components = Map<Type, dynamic>();

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(Provider<P> old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    for (var i = 0; i < this.components.length; i++) {
      dynamic component = this.components.values.elementAt(i);
      Function(dynamic) callback = this.widget.components.elementAt(i).onDispose;
      if (callback != null) {
        callback(component);
      }
    }

    super.dispose();
  }

  /// Build the widget with this state.
  @override
  Widget build(BuildContext context) {
    this.widget.components.forEach((Component component) {
      if (component.onCreated != null) {
        this.components[component.type] = component.onCreated();
      }
    });

    return InheritedProvider<P>(
      child: this.widget.child,
      components: components,
    );
  }
}

class InheritedProvider<P> extends InheritedWidget {
  /// Create a InheritedProvider widget.
  /// 
  /// The [child] argument must not be null.
  InheritedProvider({
    Key key,
    @required Widget child,
    @required this.components,
  }): assert(child != null),
      super(key: key, child: child);

  final Map<Type, dynamic> components;

  /// Notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(InheritedProvider<P> old) {
    return false;
  }
}

class Consumer extends StatelessWidget {
  /// Create a Consumer widget.
  /// 
  /// The [builder] argument must not be null.
  /// The `builder` argument used to build widget.
  /// 
  /// The [requires] argument 
  Consumer({
    Key key,
    @required this.builder,
    @required this.requires,
  }): assert(builder != null),
      super(key: key);

  final Widget Function(BuildContext context, Map<Type, dynamic> components) builder;
  final List<Type> requires;

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    Map<Type, dynamic> components = Map<Type, dynamic>();
    this.requires.forEach((Type type) {
      components[type] = Provider.of(context, component: type);
    });

    return this.builder(
      context,
      components,
    );
  }
}
