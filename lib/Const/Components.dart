
import 'package:flutter/material.dart';


Widget defaultButton (
    {
      double width = double.infinity,
      bool upper = false,
      Color color = Colors.blue,
      required String text,
      required void Function() function
    }
    )=> Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color

  ),
      height: 40.0,
      width: width,
       child:   MaterialButton(
            onPressed: function,
          child: Text( upper? text.toUpperCase() : text,
      style: TextStyle(
          color: Colors.white
      ),),

  ),
);

Widget defaultForm ({
  String? Function(String?)? onChange,
  required TextEditingController controller,
  required IconData prefix,
  IconData? suffix,
  required TextInputType type ,
  String? Function(String?)? validate,
  required String label,
  String? Function(String?)? onSupmit ,
  void Function()? onClick ,
  bool isPassword = false ,
  void Function()? onTap ,
}
    )=> TextFormField(


  onChanged:onChange ,
  onTap: onTap,
  obscureText: isPassword ? true : false,
  keyboardType: type,
  controller:controller ,
  validator: validate ,
  decoration: InputDecoration(

      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      prefixIcon: Icon (prefix),
      suffixIcon:suffix !=null ? IconButton(onPressed: onClick,icon:Icon(suffix)) : null,
      label: Text(label)

  ),
  onFieldSubmitted: onSupmit,

);





void navigatTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=> widget)
);

void navigateAndFinish (context , widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false);







String? token= '';