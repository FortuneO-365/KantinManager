import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Product extends StatelessWidget{

  final String title;
  final String quantity;
  final String price;
  bool isLow = false;
  final String? imgUrl;

  Product({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    required this.isLow,
    this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
            (imgUrl == null)
            ?
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey,
              ),
            )
            :
            Image.network(
              imgUrl!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          SizedBox(width: 16.0,),
          
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₦$price',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: isLow ? const Color.fromARGB(127, 255, 214, 79) : const Color.fromARGB(127, 100, 180, 246)
                        ),
                        child: Text(
                          "$quantity in stock",
                          style: TextStyle(
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}