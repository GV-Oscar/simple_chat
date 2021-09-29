import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomSubmitButton({Key? key, this.text = 'Continuar', this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          height: 55,
          width: double.infinity,
          child: Center(
              child: Text('${this.text}',
                  style: TextStyle(color: Colors.white, fontSize: 17))),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          elevation: 2,
        ));
  }
}
