
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Const/Components.dart';
import '../Shared/Network/CasheHelper.dart';
import 'Login/LoginScreen.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;


  BoardingModel({
    required this.image,
    required this.title,
    required this.body

  });
}




class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(image: "images/download.jpg", title: 'Title Screen 1', body: 'Body Screen 1'),
    BoardingModel(image: "images/download.jpg", title: 'Title Screen 2', body: 'Body Screen 2'),
    BoardingModel(image: "images/download.jpg", title: 'Title Screen 3', body: 'Body Screen 3'),

  ];

  bool isLast = false ;

  void submit(){
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) => {
      if(value)
        {
          navigateAndFinish(context, ShopLogInScreen())
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP'))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index){
                    if(index == boarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context , index) => BuildItem(boarding[index]),itemCount: boarding.length,)),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 125.0,),
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.teal,
                      dotColor: Colors.grey,
                      expansionFactor: 3,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 6
                  ),
                ),
                Spacer(),
                // SizedBox(width: 80.0,),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast){
                      submit();
                    }else{
                      pageController.nextPage(duration: Duration(milliseconds: 550), curve:Curves.easeIn);
                    }

                  }
                  ,child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
Widget BuildItem(BoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image(image: AssetImage('${model.image}'))),

    Text('${model.title}',
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),),
    SizedBox(height: 15.0,),
    Text('${model.body}',
      style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold
      ),),
    SizedBox(height: 30.0,),
  ],
);