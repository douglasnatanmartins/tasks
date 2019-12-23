part of '../project_detail_layout.dart';

class TitleTextField extends StatelessWidget {
  /// Build the TitleTextField widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectDetailController>(context);

    return TextField(
      autofocus: true,
      controller: TextEditingController(text: controller.project.title),
      decoration: InputDecoration.collapsed(
        hintText: 'Title',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
      ),
      cursorColor: Colors.white.withOpacity(0.5),
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      style: TextStyle(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.w500,
      ),
      onChanged: (value) {
        controller.setProjectTitle(value);
      },
    );
  }
}
