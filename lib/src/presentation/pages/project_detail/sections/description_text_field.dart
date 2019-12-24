part of '../project_detail_layout.dart';

class DescriptionTextField extends StatelessWidget {
  /// Build the DescriptionTextField widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectDetailController>(context);
    var description = controller.project.description ?? '';

    return TextField(
      controller: TextEditingController(text: description),
      decoration: InputDecoration(
        border: InputBorder.none,
        counterStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Description',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      maxLength: 255,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 17,
      ),
      onChanged: (value) {
        controller.setProjectDescription(value);
      }
    );
  }
}
