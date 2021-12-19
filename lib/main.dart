import 'package:flutter/material.dart';
import 'package:stackoverflow_reader/layer/app_layer.dart';
import 'package:stackoverflow_reader/layer/service_layer.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/page/question_page.dart';
import 'package:stackoverflow_reader/page/tag_page.dart';
import 'package:stackoverflow_reader/widget/taglist_logic.dart';

void main() {
  var service = ServiceLayer();
  var app = AppLayer();
  app.connect(service);
  service.connect(app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stackoverflow Reader',
      theme: ThemeData.dark(),
      // initialRoute:'/',
      // routes: {
      //   '/':
      // },
      home: const MyHomePage(title: 'Stackoverflow Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ViewLayer(
        // child: LayoutBuilder(
        //   builder: (BuildContext context, BoxConstraints constraits) {
        // return
        child: Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (context) => PageTag();
            break;
          case '/questions':
            builder = (context) => PageQuestions(
                  tag: settings.arguments as AppModelTag,
                );
            break;
          default:
            builder = (context) => PageTag();
        }

        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    ));
  }
}
