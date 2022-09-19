
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../styles/colors.dart';
import '../login/shop_login_new.dart';

class BoardingModel
{
  late final String image;

  late final String title;

  late final String body;

  BoardingModel({required this.image,required this.title,required this.body,});
}

class OnBoardingNewScreen extends StatefulWidget {
  const OnBoardingNewScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingNewScreenState createState()=>_OnBoardingNewScreenState();
}

class _OnBoardingNewScreenState extends State<OnBoardingNewScreen> {

  var boardController=PageController();

  List<BoardingModel>onB=[
    BoardingModel(image:'assets/images/onboarding.jpg',title: 'ًًِWelcome ',
      body:
    'Shop App',),
    BoardingModel(image:'assets/images/onboarding.jpg',title: 'Tile 2',body: 'Body 2',),
    BoardingModel(image:'assets/images/onboarding.jpg',title: 'Tile 3',body: 'Body 3',),

  ];
bool isLast=false;
void submit()
{
  CacheHelper.saveData(key: 'boarding', value: true).then((value)
  {
    if(value)
    {
            navigateAndFinish(context, LoginShopNew(),
            );
    }

  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(

          function: submit,
        text: 'Skip'),
        ],
      ),
      body: Padding(
        padding:const EdgeInsets.all(20),
      child:Column(
        children: [
         Expanded(child:  PageView.builder(
           onPageChanged: (int index)
           {
             if(index==onB.length-1)
             {
               setState(() {
               isLast=true;
             });

             }
             else
             {
               setState(() {
                 isLast=false;
               });
             }
           },
           controller: boardController,
            itemBuilder: (context, index) => buildBoardingItem(onB[index]),
          itemCount: onB.length,
          ),),
        SizedBox(height: 30,),
        Row(
          children: [
            SmoothPageIndicator(controller: boardController, count: onB.length,
            effect: ExpandingDotsEffect(
              activeDotColor: defaultColor,
              dotColor: Colors.grey,
            expansionFactor: 4,
              dotWidth: 10,
              spacing: 5.0,
            ),),
            Spacer(),
            FloatingActionButton(onPressed: ()
            {
              if(isLast)
                {
                submit();
                }
              else
                {
                  boardController.nextPage(duration: Duration(milliseconds: 750,), curve: Curves.fastLinearToSlowEaseIn,);

                }

            },
              child: Icon(Icons.arrow_forward_ios,),),
          ],
        )
        ],
      ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children:  [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
            ),
          ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]);
}
