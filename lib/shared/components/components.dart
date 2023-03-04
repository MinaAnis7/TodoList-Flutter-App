import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget defaultTF({
  required TextInputType keyboardType,
  required String text,
  required IconData prefixIcon,
  Function()? onTap,
  TextEditingController? controller,
  required String? Function(String?) validator,
  double radius = 10.0,
}) => TextFormField(
  controller: controller,
  validator: validator,
  onTap: onTap,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    prefixIcon: Icon(prefixIcon),
  ),
);

Widget taskBuildItem(model, context, String type) {
  Color doneColor = Colors.black45;
  Color archivedColor = Colors.black45;
  IconData doneIcon = Icons.check_circle_outline;
  IconData archivedIcon = Icons.archive_outlined;

  if(type == 'done')
  {
    doneColor = Colors.green;
    doneIcon = Icons.check_circle;
  }
  else if(type == 'archived')
    {
      archivedColor = Colors.blueAccent;
      archivedIcon = Icons.archive;
    }

  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            radius: 35.0,
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Task Title
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),

                //Date
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          //Done button
          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase('done', model['id'],);

            },
            icon: Icon(doneIcon, color: doneColor,),
          ),

          //archived button
          IconButton(
              onPressed: ()
              {
                AppCubit.get(context).updateDatabase('archived', model['id'],);
              },
              icon: Icon(archivedIcon, color: archivedColor,),
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteFromDatabase(model['id']);
    } ,
    background: Icon(
      Icons.delete,
      color: Colors.red,
      size: 40.0,
    ),
  );
}