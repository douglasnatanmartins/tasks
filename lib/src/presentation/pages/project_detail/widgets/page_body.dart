part of '../project_detail_page.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
    @required this.project,
    @required this.onChanged,
  }): super(key: key);

  final ProjectEntity project;
  final ValueChanged<ProjectEntity> onChanged;

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColorPicker(
        colors: DataSupport.colors.values.toList(),
        onChanged: (Color color) {
          this.onChanged(this.project.copyWith(color: color));
        },
      ),
    );
  }
}
