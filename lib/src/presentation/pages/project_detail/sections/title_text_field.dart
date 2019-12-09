part of '../project_detail_page.dart';

class _TitleTextField extends StatelessWidget {
  /// Create a Title Text Field widget.
  /// 
  /// The [controller] argument must not be null.
  _TitleTextField({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  /// Build the Title Text Field widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        autofocus: true,
        autocorrect: false,
        controller: this.controller,
        cursorColor: Colors.white.withOpacity(0.5),
        decoration: InputDecoration.collapsed(
          hintText: 'Title',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(255)],
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 21.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
