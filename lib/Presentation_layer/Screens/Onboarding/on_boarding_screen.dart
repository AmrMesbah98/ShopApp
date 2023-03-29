import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Shared_Prefrence/Sheared_Prefrence.dart';
import '../Login/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/f1.jpg',
      title: 'On Board 1 Title',
      body: 'On Borad1 body',
    ),
    BoardingModel(
      image: 'assets/images/f1.jpg',
      title: 'On Board 2 Title',
      body: 'On Borad 2 body',
    ),
    BoardingModel(
      image: 'assets/images/f1.jpg',
      title: 'On Board 3 Title',
      body: 'On Borad 3 body',
    ),
  ];

  bool islast = false;


  void submit()
  {
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
      if(value)
        {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) {
              return ShopLogin();
            }),
                (Route<dynamic> route) => false,
          );
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text('Skip' , style: TextStyle(fontSize: 25),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemCount: boarding.length,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      islast = false;
                    }
                  },
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    controller: boardController,
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${boardingModel.image}'),
              height: 350,
              width: double.infinity,
            ),
          ),
          Text(
            '${boardingModel.title}',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${boardingModel.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
        ],
      );
}
