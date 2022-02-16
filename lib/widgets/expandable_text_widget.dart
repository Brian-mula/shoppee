import 'package:flutter/material.dart';

class ExpandebleTextWidget extends StatefulWidget {
  final String text;
  const ExpandebleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandebleTextWidgetState createState() => _ExpandebleTextWidgetState();
}

class _ExpandebleTextWidgetState extends State<ExpandebleTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(
                firstHalf,
                style: const TextStyle(fontSize: 16, color: Colors.black45),
              )
            : Column(
                children: [
                  Text(
                    hiddenText ? (firstHalf + '...') : firstHalf + secondHalf,
                    style: const TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          hiddenText ? "Show more" : "Sho less",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        Icon(hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up)
                      ],
                    ),
                  )
                ],
              ));
  }
}
