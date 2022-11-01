import 'package:flutter/material.dart';
import 'package:qr_reader/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color, textColor;
  final bool disabled, loading;
  final double size;

  const RoundedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = gPrimaryColor,
    this.textColor = Colors.white,
    this.disabled = false,
    this.loading = false,
    this.size = 0.8
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * this.size,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(29),
            ),
            primary: color,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          ),
          onPressed: (disabled || loading) ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (loading)
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(),
                  ),
                ),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              )
            ],
          )),
    );
  }
}