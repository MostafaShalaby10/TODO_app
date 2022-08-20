import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/blocks/blocs.dart';

Widget itembuild(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      cub.get(context).delete(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black,
            child: Text("${model['time']}"),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model['name']}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "${model['date']}",
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          )),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                cub.get(context).updateData(status: "new", id: model['id']);
              },
              icon: Icon(
                Icons.task,
                size: 30,
              )),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                cub.get(context).updateData(status: "done", id: model['id']);
              },
              icon: Icon(
                Icons.check,
                size: 30,
              )),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                cub
                    .get(context)
                    .updateData(status: "archived", id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                size: 30,
              )),
        ],
      ),
    ),
  );
}
