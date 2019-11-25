import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

typedef ComponentCreator<T> = T Function(BuildContext context);
typedef ComponentDisposer<T> = void Function(BuildContext context, T component);

typedef ConsumerBuilder<T> = Widget Function(BuildContext context, T component);

class Component<T> extends StatefulWidget {
  /// Create a Component widget.
  Component({
    Key key,
    this.disposer,
    @required this.creator,
    @required this.child,
  }): assert(creator != null),
      assert(child != null),
      super(key: key);

  final ComponentCreator<T> creator;
  final ComponentDisposer<T> disposer;
  final Widget child;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<Component<T>> createState() => _ComponentState<T>();

  static T of<T>(BuildContext context) {
    ComponentInherited<T> inherited = self<T>(context);
    if (inherited == null) return null;
    return inherited.component;
  }

  static ComponentInherited<T> self<T>(BuildContext context) {
    Type type = _typeOf<ComponentInherited<T>>();
    ComponentInherited<T> inherited = context.inheritFromWidgetOfExactType(type);
    return inherited;
  }
}

class _ComponentState<T> extends State<Component<T>> {
  T component;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    if (this.widget.creator != null) {
      this.component = this.widget.creator(this.context);
    }
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(Component<T> old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    if (this.widget.disposer != null) {
      this.widget.disposer(this.context, this.component);
    }
    super.dispose();
  }

  /// Build the Component widget with state.
  @override
  Widget build(BuildContext context) {
    return ComponentInherited<T>(
      component: this.component,
      child: this.widget.child,
    );
  }
}

class ComponentInherited<T> extends InheritedWidget {
  /// Create a ComponentInherited widget.
  /// 
  /// The [child] argument must not be null.
  ComponentInherited({
    Key key,
    @required Widget child,
    @required this.component,
  }): assert(child != null),
      super(key: key, child: child);
  
  final T component;

  /// Notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(ComponentInherited<T> old) {
    return false;
  }
}

class Consumer<T> extends StatelessWidget {
  /// Create a Consumer widget.
  /// 
  /// The [builder] argument must not be null.
  /// The `builder` argument used to build widget.
  /// 
  /// The [requires] argument 
  Consumer({
    Key key,
    @required this.builder,
  }): assert(builder != null),
      super(key: key);

  final ConsumerBuilder<T> builder;

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    T component = Component.of<T>(context);
    return this.builder(
      context,
      component,
    );
  }
}
