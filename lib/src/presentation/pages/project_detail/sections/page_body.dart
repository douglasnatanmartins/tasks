part of '../project_detail_layout.dart';

class PageBody extends StatelessWidget {
  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectDetailController>(context);

    return ColorPicker(
      current: controller.project.color,
      colors: DataSupport.colors.values.toList(),
      onChanged: (color) {
        controller.setProjectColor(color);
      },
    );
  }
}
