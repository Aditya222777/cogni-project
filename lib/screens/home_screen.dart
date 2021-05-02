import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/emoji_button.dart';
import '../screens/triage_screen.dart';
import '../widgets/custom_safe_area.dart';
import '../models/activity.dart';
import '../providers/activities.dart';
import '../providers/rewards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Activities>(context, listen: false)
          .fetchAndSetActivities()
          .then((_) {
            return Provider.of<Rewards>(context, listen: false)
                .fetchAndSetRewards();
          })
          .catchError((err) => showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Oops!'),
                  content: Text(
                    'An unexpected error occurred when initialising data.',
                  ),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Theme.of(context).accentColor,
                      child: Text(
                        'Okay',
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ))
          .whenComplete(() {
            _isInit = false;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,

                  child: Column(

                    children: <Widget>[
                      Flexible(


                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            alignment: Alignment.topCenter,
                          ),

                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.0,
                          ),

                          child: SvgPicture.asset(
                            'assets/images/yoga.svg',
                            height: 10000.0,
                            width: 10000.0,
                            alignment: Alignment.bottomCenter,

                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: FittedBox(
                            child: Text(
                              'How Are You Feeling ...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 0.0,
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      EmojiButton(
                        height: 50.0,
                        emoji: '😫',
                        title: 'Stressed',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': Problem.Stress,
                          },
                        ),
                      ),
                      EmojiButton(
                        height: 50.0,
                        emoji: '😔',
                        title: 'Sad',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': Problem.Sad,
                          },
                        ),
                      ),
                      EmojiButton(
                        height: 50.0,
                        emoji: '😠',
                        title: 'Angry',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': Problem.Angry,
                          },
                        ),
                      ),


                      EmojiButton(
                        height: 50.0,
                        emoji: '😞',
                        title: 'Depressed',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': Problem.Depression,
                          },
                        ),
                      ),
                      EmojiButton(
                        height: 50.0,
                        emoji: '😰',
                        title: 'Anxious',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': Problem.Anxiety
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
