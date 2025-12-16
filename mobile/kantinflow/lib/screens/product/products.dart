import 'package:flutter/material.dart';
import 'package:kantin_management/widgets/product.dart';
import 'package:kantin_management/models/product_model.dart';
import 'package:kantin_management/screens/product/add_product.dart';
import 'package:kantin_management/screens/product/edit_product.dart';
import 'package:kantin_management/services/api_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget{

  const Products({super.key});

  @override
  State<StatefulWidget> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  
  int prevLength = 0;

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];

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

  void showMyPopUp(context, int id){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Confirm Delete",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: Text(
            "Are you sure you want to permanently delete this product.",
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 4.0,),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      deleteProduct(id);
                      setState(() {
                        loadProducts();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red.shade300,
                      shape: StadiumBorder(),
                      side: BorderSide(
                        width: 1,
                        color: Colors.red.shade300
                      )
                    ),
                    child: Text("Delete"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void deleteProduct(int id) async{
    final data = await ApiServices().removeProduct(productId: id);
    if (data.toString() == "Product deleted successfully"){
      showToast(context, "Product deleted successfully");
      Navigator.pop(context);
    }
    
  }

  Future<List<ProductModel>> loadProducts() async{
    dynamic data = await ApiServices().getAllProducts();
    setState(() {
      products = (data as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
      filteredProducts = products;
    });
    return products; 
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children: [ 
              Positioned.fill(
                child: Container(
                  color: Color.fromARGB(255, 245, 245, 245),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
        
                      child: Text(
                        "All Products",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey.shade300
                              ),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Products",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  "${products.length}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey.shade300
                              ),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Low Stock",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  "${products.where((p) => p.quantity < 5).length}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextSelectionTheme(
                            data: TextSelectionThemeData(),
                            child: TextFormField(
                              onChanged: (value) {
                                // Implement search functionality if needed
                                if(value.isEmpty){
                                  loadProducts();
                                }else{
                                  if(value.length < prevLength){
                                    filteredProducts = products;
                                  }
                                  setState(() {
                                    filteredProducts = filteredProducts.where((product) => product.name.toLowerCase().contains(value.toLowerCase())).toList();
                                    prevLength = value.length;
                                  });
                                }

                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0)
                                ),
                                hintText: "Search",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: filteredProducts.isNotEmpty ?
                      ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Material(
                            child: Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(), 
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async{
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditProduct(
                                          product: product,
                                        )),
                                      );

                                      if (result == true) {
                                        setState(() {
                                          loadProducts(); // refresh list
                                        });
                                      }
                                    },
                                    backgroundColor: Colors.blue.shade100,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      showMyPopUp(context, product.id);
                                      
                                    },
                                    backgroundColor: Colors.red.shade100,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ]
                              ),
                            
                              child: Product(
                                title: product.name,
                                quantity: "${product.quantity}",
                                price: "${product.sellingPrice}",
                                isLow: product.quantity < 5 ? true: false,
                                imgUrl: product.photoUrl,
                              ),
                            ),
                          );
                        },
                      )
                      :
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Container(
                            width:50,
                            height: 50,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(29, 100, 180, 246),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Icons.archive_outlined,
                              size: 26.0,
                            ),
                          ),
                          SizedBox(height: 16.0,),
                          Center(
                            child: Text(
                              "No product found",
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ),
                        ]
                      )
                    )
                  ],
                ),
              ),
        
              Positioned(
                bottom: 36.0,
                right: 26.0,
                child: IconButton.filled(
                  onPressed: () async{
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProduct()),
                    );

                    if (result == true) {
                      setState(() {
                        loadProducts(); // refresh list
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: mainColor
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    
                  )
                )
              )
            ]
          )
        );
  }
}
