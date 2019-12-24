import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/color_picker.dart';
import 'package:tasks/src/presentation/shared/pickers/icon_picker/icon_picker.dart';
import 'package:tasks/src/utils/data_support.dart';

import 'project_detail_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/action_buttons.dart';
part 'sections/title_text_field.dart';
part 'sections/description_text_field.dart';

class ProjectDetailLayout extends StatelessWidget {
  /// Create a ProjectDetailLayout widget.
  ProjectDetailLayout({
    Key key,
  }): super(key: key);

  /// Build the ProjectDetailLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          PageHeader(),
          Expanded(
            flex: 1,
            child: PageBody(),
          ),
        ],
      ),
    );
  }
}
