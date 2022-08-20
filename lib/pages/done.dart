import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/blocks/blocs.dart';
import 'package:tasks_app/blocks/states.dart';
import 'package:tasks_app/other/components.dart';

class done extends StatelessWidget {
  var skey = GlobalKey<ScaffoldState>();
  var keyform = GlobalKey<FormState>();

  var nametxt = TextEditingController();

  var datetxt = TextEditingController();

  var timetxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cub, states>(
        builder: (context, state) => Scaffold(
          key: skey,

          body: ListView.separated(
              itemBuilder: (context, index) => itembuild(cub.get(context).dones[index] , context),
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.black26,
              ),
              itemCount: cub.get(context).dones.length),
        ),
        listener: (context, state) {});
  }
}
