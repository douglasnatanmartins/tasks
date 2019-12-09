part of '../provider.dart';

/// Obtain [Component<T>] from its ancestors and pass its value to [builder].
class Consumer<T> extends StatelessWidget {
  /// Create a Consumer widget.
  ///
  /// The [builder] argument must not be null.
  Consumer({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final Widget Function(BuildContext context, T component) builder;

  /// Build the Consumer widget.
  @override
  Widget build(BuildContext context) {
    final component = Provider.of<T>(context);
    return this.builder(context, component);
  }
}
