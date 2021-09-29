import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String textLabel1;
  final String textLabel2;
  final void Function()? onPressed;

  const Labels(
      {Key? key,
      required this.textLabel1,
      required this.textLabel2,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '${this.textLabel1}',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          //SizedBox(height: 5,),
          Container(
            //margin: EdgeInsets.only(bottom: 16),
            child: TextButton(
                onPressed: this.onPressed,
                child: Column(
                  children: [
                    Text(
                      '${this.textLabel2}',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
