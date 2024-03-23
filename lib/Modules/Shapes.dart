import 'package:flutter/material.dart';

class Shapes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 200.0,
            height: 300.0,
            child: Stack(

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: 200.0,
                  height: 300.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, -4.0),
                          blurRadius: 15
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 200.0,
                    height: 100.0,

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
