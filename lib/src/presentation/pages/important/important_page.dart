import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'important_page_bloc.dart';
import 'widgets/item_list_tile.dart';
import 'widgets/page_header.dart';

class ImportantPage extends StatefulWidget {
  @override
  State<ImportantPage> createState() => _ImportantPageState();
}

class _ImportantPageState extends State<ImportantPage> {
  ImportantPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = ImportantPageBloc();
    this.bloc.refreshTasks();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.buildPage(),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          this.headerPage(),
          this.bodyPage()
        ],
      )
    );
  }

  Widget headerPage() {
    return PageHeader();
  }

  Widget bodyPage() {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: this.bloc.streamTasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return this.buildListView(snapshot.data);
              } else {
                return EmptyContentBox(message: 'not important task');
              }
            }
          }
        )
      ),
    );
  }

  Widget buildListView(List<TaskModel> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final TaskModel task = tasks[index];
        return ItemListTile(
          key: UniqueKey(),
          task: task,
          onChecked: (bool checked) {
            task.done = checked;
            this.bloc.updateTask(task);
          },
          onImportanted: (bool importanted) async {
            task.important = importanted;
            await this.bloc.updateTask(task);
            await this.bloc.refreshTasks();
          },
        );
      },
    );
  }
}
