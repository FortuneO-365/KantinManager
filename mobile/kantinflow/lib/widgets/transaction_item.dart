import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin_management/models/sales_model.dart';

class TransactionItem extends StatefulWidget{

  final SalesModel sale;

  const TransactionItem({
    super.key, 
    required this.sale
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  bool isOpen = false;

  late String day;

  String formatDateTime(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat('EEEE, d MMM yyyy • hh:mm a').format(dateTime);

  }

  @override
  void initState() {
    super.initState();
    day = formatDateTime(widget.sale.saleDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16.0),
                    child: Text(
                      widget.sale.productName!
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(widget.sale.quantitySold.toString()),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₦${widget.sale.totalPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Transform.rotate(
                          angle: isOpen ? 90 * 3.14 / 180 : 0,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 14.0,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
            isOpen 
            ? Container(
              color: Color.fromARGB(255, 250, 250, 250),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _columnItem("Transation ID", widget.sale.id.toString()),
                      SizedBox(width: 60.0,),
                      _columnItem("Product ID", "5"),
                    ],
                  ),
                  
                  SizedBox( height: 12.0,),
                  
                  _columnItem("Date & Time",day),
      
                  SizedBox(height: 4.0,),
                  Divider(thickness: 1,),
                  SizedBox(height: 4.0,),
                  
                  _summaryRow("Unit Price", "₦${widget.sale.unitPrice}"),
                  _summaryRow("Quantity", "x ${widget.sale.quantitySold}"),
                  _summaryRow("SubTotal", "₦${widget.sale.totalPrice}"),
                  _summaryRow("Tax (0%)", "₦0.00"),
                  
                  _summaryRow("Total Amount", "₦${widget.sale.totalPrice}", bold: true),
                    ],
                  ),
                )
            : Container()
            
          ],
      
        ),
      ),
    );
  }
}

Widget _columnItem(String title, String value){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey
        ),
      ),
      SizedBox(height: 4.0,),
      Text(
        value,
        style: TextStyle(
          fontSize: 14.0
        ),
      )
    ],
  );
}

Widget _summaryRow(String label, String value, {bool bold = false}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: bold ? 16: 14,
            color: Colors.grey
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 16: 14,
          ),
        ),
      ],
    ),
  );
}