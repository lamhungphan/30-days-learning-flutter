import 'package:flutter/material.dart';
import 'package:flutter_application/data/classes/activity_class.dart';
import 'package:flutter_application/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Activity activity; // late = later we will set the value
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    var url = Uri.https('bored-api.appbrewery.com', '/random');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Activity.fromJson(
        convert.jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.waiting) {
            widget = CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            Activity activity = snapshot.data;
            widget = Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeroWidget(title: 'Course'),
                    Text(activity.activity),
                  ],
                ),
              ),
            );
          } else {
            widget = Center(child: Text('Error'));
          }
          return widget;
        },
      ),
    );
  }
}
