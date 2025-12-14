import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin_management/widgets/image_picker_field.dart';
import 'package:kantin_management/widgets/product_text_field.dart';
import 'package:kantin_management/models/product_model.dart';
import 'package:kantin_management/services/api_services.dart';

class EditProduct extends StatefulWidget{
  final ProductModel product;
  
  const EditProduct({
    super.key,
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController cProductName = TextEditingController();

  final TextEditingController cPrice = TextEditingController();

  final TextEditingController cQuantity = TextEditingController();

  XFile? _image;

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Colors.blue.shade300,
          backgroundColor: const Color.fromARGB(50, 255, 255, 255),
        ),
      ),
    );
  }

  void hideLoading(BuildContext context) {
    Navigator.pop(context);
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

  bool validateInput(BuildContext context){
    String productName = cProductName.text.trim();
    String priceText = cPrice.text.trim();
    String quantityText = cQuantity.text.trim();

    if(productName.isEmpty){
      // Show error for product name
      showToast(context,"Product name cannot be empty");
      return false;
    }

    double? price = double.tryParse(priceText);
    if(price == null || price < 0){
      // Show error for price
      showToast(context,"Enter a valid price");
      return false;
    }

    int? quantity = int.tryParse(quantityText);
    if(quantity == null || quantity < 0){
      // Show error for quantity
      showToast(context,"Enter a valid quantity");
      return false;
    }

    // Input is valid, proceed with further actions
    return true;
  }

  void editProduct(BuildContext context) async{
    if(validateInput(context)){
      showLoading(context);
      dynamic data = await ApiServices().editProduct(
        productId: widget.product.id,
        productName: cProductName.text.trim(), 
        sellingPrice: double.parse(cPrice.text.trim()), 
        quantity: int.parse(cQuantity.text.trim())
      );

      print(data);

      if(data.toString() != "Product Updated Successfully"){
        showToast(context, "Unable to edit product");
        return;
      }

      if (_image == null){
        hideLoading(context);
        Navigator.pop(context, true);
        return;
      }

      dynamic dataImage = await ApiServices().uploadProductImage(
        productId:  widget.product.id,
        imageFile: _image!
      );

      hideLoading(context);

      if (dataImage is Map && dataImage["message"] == "Image added successfully") {
        Navigator.pop(context, true);
        return;
      }

      showToast(context, "Unable to upload image");
      Navigator.pop(context, true);    
    }
  }

  @override
  void initState() {
    super.initState();
    cProductName.text = widget.product.name;
    cPrice.text = widget.product.sellingPrice.toString();
    cQuantity.text = widget.product.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 18,
        ),
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        shape: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white70
          )
        ),
        title: Text(
          "Edit Product",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(127, 187, 222, 251)
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined
                  ),
                ),
                SizedBox(width: 16.0,),
                Column(
                  children: [
                    Text(
                      "Product Information",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                    Text("Fill in all required fields"),
                  ],
                )
              ],
            ),

            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),

            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      ProductTextField(
                        title: "Product Name", 
                        hint: "e.g Wireless Mouse", 
                        keyboardType: TextInputType.text,
                        controller: cProductName,
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Currency",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0
                            ),
                          ),
                          SizedBox(height: 8.0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
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
                            items: ["Nigerian Naira (NGN)", "US Dollar (USD)", "Euro (EUR)", "British Pound (GBP)"]
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    )) 
                                .toList(),
                            initialValue: "Nigerian Naira (NGN)",
                            onChanged: null
                            
                          )
                        ]
                      ),
                      SizedBox(height: 16.0),
                      ProductTextField(
                        title: "Price", 
                        hint: "0.00", 
                        keyboardType: TextInputType.number,
                        controller: cPrice,
                      ),
                      SizedBox(height: 16.0),
                      ProductTextField(
                        title: "Quantity", 
                        hint: "0", 
                        keyboardType: TextInputType.number,
                        controller: cQuantity,
                      ),
                      SizedBox(height: 16.0),
                      widget.product.photoUrl != null
                      ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Previous Image:"),
                            Container(
                              color: Color.fromARGB(255, 250, 250, 250),
                              padding: EdgeInsets.all(8.0),
                              child: Image.network(
                                widget.product.photoUrl!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0,),
                            ImagePickerField(
                              selectedImage: _image,
                              onImageSelected: (XFile? image){
                                setState(() {
                                  _image = image;
                                });
                              },
                            ),
                          ],
                        )
                      :
                      ImagePickerField(
                        selectedImage: _image,
                        onImageSelected: (XFile? image){
                          setState(() {
                            _image = image;
                          });
                        },
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: (){
                          editProduct(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.blue.shade300,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(4.0)
                          )
                        ),
                        child: Text("Edit Product",)
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}