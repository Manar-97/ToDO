import 'package:flutter/material.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';
import 'package:tooodooo/UI/utils/App_Style.dart';

import '../../../../../model/todo_dm.dart';

class Todo extends StatelessWidget {
  final TodoDM item;
  const Todo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Row(
        children: [
          buildVerticalLine(context),
          const SizedBox(
            width: 25,
          ),
          buildTodoInfo(),
          buildTodoState(),
        ],
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              item.title,
              style: AppStyles.titleTextStyle,
                maxLines: 1,
            ),
            const Spacer(),
            Text(
              item.description,
              style: AppStyles.bodyTextStyle,
            ),
            const Spacer(),
          ],
        ),
      );

   buildTodoState() => Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
    child:const Icon(Icons.done,color: Colors.white,size: 30,),
  );
}
