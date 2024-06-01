import 'package:flutter/material.dart';
import '../../song.dart';

class ProgressIndicatorExample extends StatefulWidget {
  final Song song;
  const ProgressIndicatorExample({super.key, required this.song});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    super.initState();
    var length = widget.song.length.toString().split(".");
    int min = int.parse(length[0]);
    int sec = int.parse(length[1]);
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: min, seconds: sec),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.song.length.toString().split(".");
    int min = int.parse(length[0]);
    int sec = int.parse(length[1]);
    int totalDuration = (min * 60) + sec;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          LinearProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
            backgroundColor: Colors.grey,
            color: Colors.white,
            minHeight: 3,
          ),
          const SizedBox(height: 2.5),
          Row(
            children: [
              Text(
                "${(controller.value * totalDuration ~/ 60).toInt()}"
                ":${(controller.value * totalDuration % 60).toInt()}",
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              const Spacer(),
              Text(
                "$min:$sec",
                style: const TextStyle(fontSize: 13, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shuffle, color: Colors.white),
                iconSize: 27,
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
                iconSize: 40,
                onPressed: () {},
              ),
              IconButton(
                icon: determinate
                    ? const Icon(Icons.play_circle, color: Colors.white)
                    : const Icon(Icons.pause_circle, color: Colors.white),
                iconSize: 60,
                onPressed: () {
                  var value = !determinate;
                  setState(() {
                    determinate = value;
                    if (determinate) {
                      controller.stop();
                    } else {
                      controller
                        ..forward(from: controller.value)
                        ..repeat();
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
                iconSize: 40,
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.repeat,
                  color: Colors.white,
                ),
                iconSize: 27,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
