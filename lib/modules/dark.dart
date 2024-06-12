import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//enum MyThemeMode {
 // light,
//  dark,
//  third,
//}
class BrightnessSelectionScreen extends StatelessWidget {
  const BrightnessSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final themeMode = Provider.of<ValueNotifier<MyThemeMode>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Brightness'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
     //     RadioListTile<MyThemeMode>(
     //       title:  Text('Light Mode',
     //       style: Theme.of(context).textTheme.bodyText1,
      //      ),
      //      value:MyThemeMode .light,
       //     groupValue: themeMode.value,
       //     onChanged: (value) {
        //      themeMode.value = value!;

        //    },
        //  ),
       //   RadioListTile<MyThemeMode>(
       //     title:  Text('Dark Mode',
        //      style: Theme.of(context).textTheme.bodyText1,
        //    ),
         //   value: MyThemeMode .dark,
         //   groupValue: themeMode.value,
         //   onChanged: (value) {
         //     themeMode.value = value!;
          //  },
         // ),
        //  RadioListTile<MyThemeMode>(
        //    title:  Text('Third Mode',
        //      style: Theme.of(context).textTheme.bodyText1,
        //    ),
        //    value: MyThemeMode.third,
          //  groupValue: themeMode.value,
          //  onChanged: (value) {
           //   themeMode.value = value!;
           // },
         // ),
        ],
      ),
    );
  }
}
