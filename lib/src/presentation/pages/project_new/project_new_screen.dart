import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/color_picker.dart';
import 'package:tasks/src/presentation/shared/pickers/icon_picker/icon_picker.dart';
import 'package:tasks/src/utils/data_support.dart';

class ProjectNewScreen extends StatefulWidget {
  ProjectNewScreen({
    Key key,
    @required this.category,
  }): assert(category != null),
      super(key: key);

  final int category;

  @override
  State<StatefulWidget> createState() => _ProjectNewScreenState();
}

class _ProjectNewScreenState extends State<ProjectNewScreen> {
  Color color;
  IconData icon;
  TextEditingController editingTitle;
  TextEditingController editingDescription;

  @override
  void initState() {
    super.initState();
    this.color = DataSupport.colors.values.elementAt(0);
    this.icon = DataSupport.icons.values.elementAt(0);
    this.editingTitle = TextEditingController();
    this.editingDescription = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeIcon(IconData data) {
    setState(() {
      this.icon = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.buildPage()
    );
  }

  Widget buildPage() {
    return Column(
      children: <Widget>[
        this.pageHeader(),
        this.pageBody()
      ],
    );
  }

  Widget pageHeader() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: this.color
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              this.theActions(),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  this.iconPicker(),
                  Expanded(
                    child: this.headerTitle()
                  )
                ],
              ),
              SizedBox(height: 5.0),
              this.textFieldDescription(),
            ]
          ),
        ),
      )
    );
  }

  Widget iconPicker() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Icon(this.icon, color: Colors.white),
      ),
      onTap: () {
        showModalBottomSheet(
          context: this.context,
          builder: (BuildContext context) {
            return Container(
              child: IconPicker(
                icons: DataSupport.icons.values.toList(),
                current: this.icon,
                onChanged: this.changeIcon
              )
            );
          }
        );
      }
    );
  }

  Widget headerTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: this.editingTitle,
        autofocus: true,
        textAlignVertical: TextAlignVertical.center,
        autocorrect: false,
        decoration: InputDecoration.collapsed(
          hintText: 'Title',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.4),
          )
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(255)
        ],
        cursorColor: Colors.white.withOpacity(0.5),
        style: TextStyle(
          color: Colors.white,
          fontSize: 21.0,
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  Widget textFieldDescription() {
    return Container(
      child: TextField(
        controller: this.editingDescription,
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.4)
          ),
          counterStyle: TextStyle(
            color: Colors.white
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none
        ),
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 17.0
        ),
        maxLength: 255,
      )
    );
  }

  Widget pageBody() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            this.theColorPicker(),
          ],
        ),
      )
    );
  }

  Widget theColorPicker() {
    return ColorPicker(
      colors: DataSupport.colors.values.toList(),
      onChanged: (Color selected) {
        setState(() {
          this.color = selected;
        });
      }
    );
  }

  Widget theActions() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: Colors.white
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.grey.shade400,
            textColor: Colors.white,
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(this.context).pop(false),
          ),
          SizedBox(width: 10.0),
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: Colors.white
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.green.shade400,
            textColor: Colors.white,
            child: const Text('New'),
            onPressed: () {
              final title = this.editingTitle.text.trim();
              if (title.isNotEmpty) {
                final description = this.editingDescription.text.trim();
                ProjectModel model = ProjectModel(
                  categoryId: this.widget.category,
                  title: this.editingTitle.text,
                  description: description,
                  created: DateTime.now(),
                  color: this.color,
                  icon: this.icon
                );
                Navigator.of(this.context).pop(model);
              }
            },
          ),
        ],
      ),
    );
  }
}
