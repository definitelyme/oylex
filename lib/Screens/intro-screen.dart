import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Screens/auth/login.dart';
import 'package:oylex/components/intro-screen-model.dart';

class IntroScreen extends StatefulWidget {
  static final routeName = "/welcome-screen";
//  static final routeName = "/";

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final btnStyle = defaultTextTheme().button.copyWith(color: Colors.black, fontSize: 17, letterSpacing: 1.1);
  final introKey = GlobalKey<IntroductionScreenState>();

  // To hold the list of IntroScreen Widgets
  List<PageViewModel> _pageViewModelList = List();

  // To hold the list of IntroScreen models
  List<WelcomeScreen> _screens = List();

  void _donePressed() => navigateAndPush(context: context, routeName: LoginScreen.routeName);

  PageViewModel _createIntroScreens(WelcomeScreen screen) {
    // Decoration for each Page or Screen
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    // The Actual Intro Widget to be rendered
    return PageViewModel(
        title: "", // Don not remove this, else Flutter will squawk!
        bodyWidget: Column(
          children: <Widget>[
            Align(
              child: Image.asset(
                screen.image,
                height: screen.imageHeight,
                width: screen.imageWidth,
              ),
              alignment: Alignment.bottomCenter,
            ),
//            Text(
//              screen.title,
//              style: deviceFontTheme().display4.copyWith(
//                  color: Colors.black,
//                  fontSize: 17,
//                  letterSpacing: 1.1,
//                  fontWeight: FontWeight.w600),
//            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              screen.description,
              style: defaultTextTheme().display4.copyWith(color: Colors.black, fontSize: 16, letterSpacing: 1.1),
              textAlign: TextAlign.center,
            )
          ],
        ),
        decoration: pageDecoration);
  }

  @override
  void initState() {
    super.initState();

    _screens.add(
      WelcomeScreen(
        image: "assets/images/intro/learn.png",
        title: "Learning simplified",
        description: "We make learning simplified, \nfocusing on consistency and perfection",
      ),
    );
    _screens.add(
      WelcomeScreen(
        image: "assets/images/intro/4.png",
        title: "You get to Pick",
        description: "Information, facts & documentations \nprovided out of the box",
      ),
    );
    _screens.add(
      WelcomeScreen(
        image: "assets/images/intro/5.png",
        title: "Content means everything",
        description: "You feel comfortable with videos? \nWe got you covered!",
      ),
    );
    _screens.add(
      WelcomeScreen(
        image: "assets/images/intro/6.png",
        title: "Compact Study Guide",
        description: "Self-guided offline materials \nthat you can can access on your own \nanytime, anywhere",
      ),
    );
    _screens.add(
      WelcomeScreen(
        image: "assets/images/intro/2.png",
        title: "Certification? Yes!",
        description: "Start with performance, end with performance.",
      ),
    );

    // Foreach of the above instances, create an IntroScreen & it to the PageViewModel List
    _screens.forEach((elem) => _pageViewModelList.add(_createIntroScreens(elem)));
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: _pageViewModelList,
      initialPage: 0,
      showSkipButton: true,
      skip: Container(padding: const EdgeInsets.symmetric(vertical: 10.0), child: Text("Skip", style: btnStyle)),
      showNextButton: true,
      next: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black87,
        ),
      ),
      done: Text(
        "Get Started",
        style: btnStyle,
      ),
      dotsFlex: 2,
      skipFlex: 0,
      nextFlex: 0,
      isProgress: true,
      globalBackgroundColor: AppColors.windowBackground,
      onDone: _donePressed,
      onSkip: _donePressed,
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.oylexAccent.shade400,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
