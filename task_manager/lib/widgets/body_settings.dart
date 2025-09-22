import 'package:flutter/material.dart';
import 'package:task_manager/widgets/ui_kit/toggle_slider_button.dart';

class BodySettings extends StatefulWidget {
  const BodySettings({super.key});

  @override
  State<BodySettings> createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25,),

          //Title
           Center(
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Expanded(flex:1, child: Icon(Icons.settings,size: 40,color: Colors.white,)),
                  Expanded(flex: 2 , child: Text('Settings',style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ),

          Divider(height: 25,color: Colors.white,thickness: 1, indent: 150, endIndent: 150,),

          SizedBox(height: 15,),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'data',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      ToggleSliderButton(onChanged: null),
                    ],
                  ),
                  Divider(height: 15,thickness: 1.5,color: Colors.white,),

                  SizedBox(height: 20,),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'data',
                  //       style: TextStyle(
                  //         color: Colors.white, 
                  //         fontSize: 20, 
                  //         fontWeight: FontWeight.bold
                  //       ),
                  //     ),

                  //     ToggleSliderButton(onChanged: null),
                  //   ],
                  // ),
                  // Divider(height: 15,thickness: 1.5,color: Colors.white,),

                  // SizedBox(height: 20,),
              
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}