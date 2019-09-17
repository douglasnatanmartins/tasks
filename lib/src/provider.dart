import 'package:flutter/material.dart';
import 'package:tasks/src/core/contracts/bloc_contract.dart';

Type _typeOf<T>() => T;

class Provider<T extends BlocContract> extends StatefulWidget {
  Provider({
    Key key,
    this.bloc,
    this.child
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _ProviderState<T> createState() {
    return _ProviderState<T>();
  }

  static T of<T extends BlocContract>(BuildContext context) {
    final type = _typeOf<_ProviderInherited<T>>();
    _ProviderInherited provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _ProviderState<T extends BlocContract> extends State<Provider<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ProviderInherited(bloc: widget.bloc, child: widget.child);
  }
}

class _ProviderInherited<T> extends InheritedWidget {
  _ProviderInherited({
    Key key,
    this.bloc,
    Widget child
  }): super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
