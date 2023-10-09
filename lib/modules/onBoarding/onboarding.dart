import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/LoginScreen.dart';
import 'package:shop_app/shared/shared%20preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';

class OnBoardModel{
  final String title;
  final String body;
  final String Image;

  OnBoardModel(this.title, this.body, this.Image);

}

class OnBoarding extends StatefulWidget{
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  List<OnBoardModel> list = [
    OnBoardModel("On Board 1 Title", "On Board 1 Body", "assets/images/onboard_1.jpg"),
    OnBoardModel("On Board 2 Title", "On Board 2 Body", "assets/images/onboard_1.jpg"),
    OnBoardModel("On Board 3 Title", "On Board 3 Body", "assets/images/onboard_1.jpg"),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    onPageChanged: (index){
                    currentIndex = index;
                    },
                    itemBuilder: (context ,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image(image: AssetImage('${list[index].Image}'))),
                          Text("${list[index].title}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 30,),
                          Text("${list[index].body}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      );
                    },
                  ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmoothPageIndicator(controller: controller, count: 3, effect: ExpandingDotsEffect(spacing: 4,expansionFactor: 5,dotHeight: 14,dotWidth: 13),),
                  Spacer(),
                  FloatingActionButton(
                    onPressed:(){
                      setState(() {
                        if(currentIndex != list.length -1) {
                          controller.nextPage(duration: Duration(
                              milliseconds: 750), curve: Curves
                              .fastLinearToSlowEaseIn);
                        }
                        else{
                          NavigateAndReplace(context, LoginScreen());
                          CashHelper.saveData(key: 'onBoarding', value: true);
                        }
                      });
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),)
                ],
              ),
            ],
          ),
      ),

    );
  }
}