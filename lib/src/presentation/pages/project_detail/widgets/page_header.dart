part of '../project_detail_page.dart';

class _PageHeader extends StatefulWidget {
  /// Create a Page Header widget.
  ///
  /// The [data] argument must not be null.
  _PageHeader({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  final ProjectEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<_PageHeader> {
  IconData icon;
  TextEditingController titleController;
  TextEditingController descriptionController;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.icon = this.widget.data.icon;

    this.titleController = TextEditingController.fromValue(
      TextEditingValue(text: this.widget.data.title),
    );

    this.descriptionController = TextEditingController.fromValue(
      TextEditingValue(text: this.widget.data.description ?? ''),
    );
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_PageHeader old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.titleController.dispose();
    this.descriptionController.dispose();
    super.dispose();
  }

  /// Build the Page Header widget with state.
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: this.widget.data.color,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _ActionButtons(
                onSaved: () {
                  final title = this.titleController.text.trim();
                  if (title.isNotEmpty) {
                    final description = this.descriptionController.text.trim();
                    ProjectEntity entity = this.widget.data.copyWith(
                      title: title,
                      description: description.isEmpty ? null : description,
                      icon: this.icon,
                    );
                    Navigator.of(context).pop(entity);
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter title.')),
                    );
                  }
                },
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconPicker(
                      icons: DataSupport.icons.values.toList(),
                      current: this.icon,
                      onChanged: (IconData icon) {
                        this.icon = icon;
                      }),
                  Expanded(
                    child: _TitleTextField(
                      controller: this.titleController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              _DescriptionTextField(
                controller: this.descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
