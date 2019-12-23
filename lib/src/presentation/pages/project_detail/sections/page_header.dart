part of '../project_detail_layout.dart';

class PageHeader extends StatelessWidget {
  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectDetailController>(context);

    return Container(
      height: 230,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          StreamBuilder<Color>(
            initialData: controller.project.color,
            stream: controller.colorStream,
            builder: (context, snapshot) {
              var color = snapshot.data;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.linear,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ActionButtons(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconPicker(
                        icons: DataSupport.icons.values.toList(),
                        current: controller.project.icon,
                        onChanged: (icon) {
                          controller.setProjectIcon(icon);
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: TitleTextField(),
                      ),
                    ],
                  ),
                  DescriptionTextField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
