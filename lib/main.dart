import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = TextEditingController();
  var enabled = false;
  List<Score> score = [];
  double rate = 0;
  @override
  void initState() {
    super.initState();
    score.add(Score(rate: 2.5, comment: '맛나요'));
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Text('${score[index].rate}'),
        title: Text(score[index].comment),
      ),
    );
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              setState(() {
                enabled = true;
                rate = value;
              });
            },
          ),
          TextFormField(
            controller: textEditingController,
            enabled: enabled,
            decoration: const InputDecoration(
                hintText: '한마디 해주세요.', label: Text('여긴뭘까')),
            maxLength: 200,
          ),
          ElevatedButton(
            onPressed: enabled
                ? () {
                    score.add(
                        Score(rate: rate, comment: textEditingController.text));
                    setState(() {
                      listView;
                    });
                  }
                : null,
            child: const Text('저장하기'),
          ),
          Expanded(
            child: listView,
          ),
        ],
      )),
    );
  }
}

class Score {
  double rate;
  String comment;
  Score({required this.rate, required this.comment});
}
