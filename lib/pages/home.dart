import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/blocks/blocs.dart';
import 'package:tasks_app/blocks/states.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => cub(),
      child: BlocConsumer<cub, states>(
        builder: (context, state) => Scaffold(

          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cub.get(context).switchpages(value);
            },
            currentIndex: cub.get(context).current_index,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline), label: "Done"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: "Archive"),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
                cub.get(context).title[cub.get(context).current_index] ,
            style: TextStyle(
              fontSize: 25 ,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          body: cub.get(context).pages[cub.get(context).current_index],
        ),
        listener: (context, state) {},
      ),
    );
  }
}
