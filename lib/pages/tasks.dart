import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/blocks/blocs.dart';
import 'package:tasks_app/blocks/states.dart';
import 'package:tasks_app/other/components.dart';
import 'package:tasks_app/other/database.dart';

class task extends StatelessWidget {
  var skey = GlobalKey<ScaffoldState>();
  var keyform = GlobalKey<FormState>();

  var nametxt = TextEditingController();

  var datetxt = TextEditingController();

  var timetxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cub.get(context).createdb() ;
    return BlocConsumer<cub, states>(
        builder: (context, state) => Scaffold(
              key: skey,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  if (cub.get(context).isshow) {
                    Navigator.pop(context);
                    cub
                        .get(context)
                        .opensheet(isshown: false, icon: Icons.edit);
                    // ficcon = Icons.add ;
                    // isshown = true ;
                  } else {
                    skey.currentState!
                        .showBottomSheet(
                            (context) => Container(
                                  color: Colors.white38,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: keyform,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: nametxt,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "please enter name";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                label: Text("Enter name"),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              onTap: ()
                                              {
                                                showTimePicker(context: context,
                                                    initialTime: TimeOfDay.now()
                                                ).then((value)
                                                {
                                                  timetxt.text = value!.format(context).toString() ;
                                                  print(value.format(context)) ;
                                                }) ;
                                              },
                                              controller: timetxt,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the time";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                label: Text("Enter time"),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              onTap: ()
                                              {
                                                showDatePicker(context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse('2030-12-31')).then((value)
                                                {
                                                  datetxt.text =  DateFormat.yMMMd().format(value!) ;
                                                }) ;
                                              },
                                              controller: datetxt,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "please enter date";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                label: Text("Enter date"),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: MaterialButton(
                                                color: Colors.black,
                                                onPressed: () {
                                                  if (keyform.currentState!
                                                      .validate()) {
                                                    cub.get(context).insert(
                                                        name: nametxt.text,
                                                        date: datetxt.text,
                                                        time: timetxt.text);
                                                  }
                                                  Navigator.pop(context);
                                                  cub
                                                      .get(context)
                                                      .opensheet(isshown: false, icon: Icons.edit);

                                                  nametxt.text = "" ;
                                                  datetxt.text = "" ;
                                                  timetxt.text = "" ;
                                                },
                                                child: Text(
                                                  "Insert",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            elevation: 20.0)
                        .closed
                        .then((value) {
                      cub
                          .get(context)
                          .opensheet(isshown: false, icon: Icons.edit);
                    });
                    cub.get(context).opensheet(isshown: true, icon: Icons.add);
                  }
                },
                child: Icon(cub.get(context).ficcon),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) => itembuild(cub.get(context).tasks[index] , context),
                  separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: Colors.black26,
                      ),
                  itemCount: cub.get(context).tasks.length),
            ),
        listener: (context, state) {});
  }
}
