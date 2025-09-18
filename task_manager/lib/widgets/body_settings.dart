import 'package:flutter/material.dart';

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

          Divider(height: 25,color: Colors.white,thickness: 1, indent: 65, endIndent: 65,),

          
        ],
      )
    );
  }
}