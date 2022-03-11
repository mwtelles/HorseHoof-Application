import 'package:flutter/material.dart';

class CardCounter extends StatelessWidget {
  final String titulo;
  final int count;

  const CardCounter(this.titulo, this.count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight:  Radius.circular(20),bottomRight:  Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: ThemeData().primaryColor,
              width: 6
            ),
          ),
            color: const Color.fromRGBO(123, 133, 143, 1),
             
            ),
        height: 88,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ), 
              Text(
                count.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
