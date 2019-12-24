part of 'color_picker.dart';

class _ColorGridItem extends StatelessWidget {
  /// Create a _ColorGridItem widget.
  /// 
  /// The [selected], [color], and [onTap] arguments must not be null.
  _ColorGridItem({
    Key key,
    @required this.color,
    @required this.isChecked,
    @required this.onTap,
  }): assert(color != null),
      assert(isChecked != null),
      assert(onTap != null),
      super(key: key);

  final Color color;
  final bool isChecked;
  final VoidCallback onTap;

  /// Build the _ColorGridItem widget.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: AnimatedContainer(
          width: 32,
          height: 32,
          duration: const Duration(milliseconds: 210),
          padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: this.isChecked
                      ? Border.all(color: this.color, width: 3)
                      : null,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
