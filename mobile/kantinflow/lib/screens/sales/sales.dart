import 'package:flutter/material.dart';
import 'package:kantin_management/widgets/counter_input.dart';
import 'package:kantin_management/screens/sales/sales_history.dart';
import 'package:kantin_management/models/product_model.dart';
import 'package:kantin_management/services/api_services.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});
  
  @override
  SalesState createState() => SalesState();
}

class SalesState extends State<Sales> {

  bool isSelected = false;
  List<ProductModel> products = [];
  int selectedProductId = -1;
  int quantity = 1;
  ProductModel? product;

  void increaseQuantity(){
    if (quantity >= product!.quantity){
      return ;
    }
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity(){
    if (quantity <= 1){
      return ;
    }
    setState(() {
      quantity--;
    });
  }

  void selectProduct(int id){

    final model = products.firstWhere(
      (p) => p.id == id
    );
    setState(() {
      product = model;
      isSelected = true;
    });
  }

  void showToast(BuildContext context,String message){
    // Implement toast message display
      OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Position from the bottom
        left: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        right: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void validateInput(){
    if(quantity < 1){
      showToast(context, "Quantity is 0");
      return;
    }

    if(selectedProductId <= 0){
      showToast(context, "No product selected");
      return; 
    }

  } 

  void recordSale() async{
    validateInput();

    final data = await ApiServices().recordSale(
      productId: selectedProductId,
      quantitySold: quantity
    );


    if(data["message"] == "Sale recorded successfully"){
      showToast(context, "Sale recorded successfully");
      setState(() {
        quantity = 1;
      });
      loadProducts();
    }else{
      showToast(context, "Failed to record sale");
    }
  }

  Future<List<ProductModel>> loadProducts() async{
    dynamic data = await ApiServices().getAllProducts();
    setState(() {
        products = (data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

        if (products.isNotEmpty && selectedProductId == -1) {
          selectedProductId = products.first.id;
        }

        selectProduct(selectedProductId);
    });
    return products; 
  }

  @override
  void initState(){
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sales",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SalesHistory()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue.shade300
                      ), 
                      child: Text("History")
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(85, 100, 180, 246),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              SizedBox(width: 16.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "New Sale",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text("Record a transaction"),
                                ],
                              )
                            ],
                          ),
                    
                          SizedBox(height: 8.0,),
                          Divider(),
                          SizedBox(height: 12.0,),
                    
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select product",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  DropdownButtonFormField(
                                    initialValue: selectedProductId == -1 ? null : selectedProductId,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300
                                        )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300
                                        )
                                      ),
                                    ),
                                    items: products
                                        .map((product) => DropdownMenuItem(
                                              value: product.id,
                                              child: Text(product.name),
                                            )) 
                                        .toList(),
                                    onChanged: (product) {
                                      setState(() {
                                        selectedProductId = product!;
                                        quantity = 1;
                                      });
                                      selectProduct(product!);
                                    }
                                    
                                  ),
                                ],
                              ),
                            ],
                          ),
                    
                          SizedBox(height: 16.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                                ),
                              ),
                              SizedBox(height: 8.0),
                              CounterInput(
                                value: quantity,
                                onIncrement: () {
                                  increaseQuantity();
                                },
                                onDecrement: () {
                                  decreaseQuantity();
                                },
                              ),
                            ]
                          ),
                          SizedBox(height: 16.0,),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(8.0),
                              border: BoxBorder.all(
                                color: Colors.grey.shade300
                              )
                            ),
                            child: isSelected ? 
                            Row(
                              children: [
                                product!.photoUrl != null
                                ?
                                Image.network(
                                  product!.photoUrl!,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )
                                :
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product!.name),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Price",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0
                                              ),
                                            ),
                                            Text("₦${product!.sellingPrice}")
                                          ],
                                        ),
                                        SizedBox(width: 40.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Stock",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0
                                              ),
                                            ),
                                            Text("${product!.quantity} units")
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                            :
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Preview",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0
                                  ),
                                ),
                                SizedBox(height: 12.0,),
                                Text(
                                  "No product selected",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ),
                          SizedBox(height: 16.0,),
                          Container(
                            child: isSelected ? 
                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(192, 187, 222, 251),
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.blue.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment. start,
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                    
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline_rounded,
                                              size: 14.0,
                                            ),
                                            SizedBox(width: 4.0,),
                                            Text("$quantity × ₦${product!.sellingPrice}")
                                          ],
                                        )
                                      ],
                                    ),
                    
                                    Text(
                                      "₦${product!.sellingPrice * quantity}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              )
                              :
                              Container(),
                          ),
                    
                          SizedBox(height: 16.0,),
                          Container(),
                    
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  recordSale();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade300,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(8.0),
                                  )
                                ), 
                                child: Text(
                                  "Record Sale"
                                )
                              ),
                            ],
                          )
                    
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
