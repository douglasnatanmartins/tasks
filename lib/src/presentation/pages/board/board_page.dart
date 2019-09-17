import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';
import 'package:tasks/src/presentation/ui_colors.dart';
import 'package:tasks/src/provider.dart';

class BoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BoardPageState();
  }
}

class _BoardPageState extends State<BoardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomePageBloc>(context).refreshTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<HomePageBloc>(context).streamTasks,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            List<TaskModel> data = snapshot.data;
            return _buildListView(data);
          } else {
            return EmptyContentBox(message: 'not important task');
          }
        }
      }
    );
  }

  Widget _buildListView(List<TaskModel> data) {
    List<dynamic> source = ['Important'];
    source.addAll(data);
    return ListView.builder(
      itemCount: source.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildChildrenInListView(source[index]);
      }
    );
  }

  Widget _buildChildrenInListView(dynamic data) {
    if (data is String) {
      return _buildListTileHeader(data);
    } else {
      return _buildListTile(data);
    }
  }

  Widget _buildListTileHeader(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20.0, right: 20.0, bottom: 20.0),
      child: Text(
        title,
        style: TextStyle(
          color: UIColors.TextSubHeader,
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  Widget _buildListTile(TaskModel task) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: Key(task.id.toString()),
      child: TaskListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checked) {
            task.done = checked;
            Provider.of<HomePageBloc>(context).updateTask(task);
          }
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: UIColors.TextHeader,
            fontWeight: FontWeight.w600
          )
        )
      ),
      onDismissed: (direction) {
        task.important = false;
        Provider.of<HomePageBloc>(context).updateTask(task);
        Provider.of<HomePageBloc>(context).announceImportantTasks();
      },
    );
  }
}
