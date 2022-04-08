import 'package:flutter/cupertino.dart';
import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/show_warning_before_delete_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/top_bar_widget_admins.dart';
import '../uploadingImagesAndproducts.dart';
import 'admin_edit_product.dart';

void showWarning(context, var data) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text('Do you really want to delete this product? '),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  String message =
                      await ProductUploadingAndDispalyingFunctions().deleteProduct(data);
                  Navigator.of(context).pop();
                  showMessage(context, message);
                },
                child: Text('Ok')),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'))
          ],
        );
      });
}

void showMessage(context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('Ok')),
          ],
        );
      });
}

class AdminShowProductsEditDelete extends StatefulWidget {
  static const String id = '/dispalyProductsToBeEdited';

  @override
  _AdminShowProductsEditDeleteState createState() =>
      _AdminShowProductsEditDeleteState();
}

class _AdminShowProductsEditDeleteState
    extends State<AdminShowProductsEditDelete> {
  bool done = true;
  ProductsAndCategories? productsAndCategories;

  Product? product = Product();
  Widget productAttributes({
    double? sizeTitle,
    double? sizedata,
    Color? colorTitle,
    Color? colorData,
    String? fontFamilyTitle,
    String? fontFamilydata,
  }) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.id}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Categoria',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.category}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Nombre',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.nombre_producto}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Marca',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.marca}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Contenido',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.contenido}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Typo de impuesto',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.typo_impuesto}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'porciento de impuesto',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.porciento_impuesto}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Precio',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.precio_anterior}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'Precio Antes',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.precio_anterior}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
              Text(
                'descripcion',
                style: TextStyle(
                    fontSize: sizeTitle,
                    color: colorTitle,
                    fontFamily: fontFamilyTitle),
              ),
              Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
              Text(
                '${product?.descripcion}',
                style: TextStyle(
                    fontSize: sizedata,
                    color: colorData,
                    fontFamily: fontFamilydata),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? idOfSelectedProduct;

  @override
  void initState() {
    AddProductAdminFunction().getProducts().then((value) {
      setState(() {
        productsAndCategories = value;

        done = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? productId;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),
            SizedBox(height: 10,),
            Expanded(
                child: productsAndCategories != null ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                          itemCount: productsAndCategories?.listOfProducts.length,
                          itemBuilder: (context, int index) {
                            product = productsAndCategories?.listOfProducts[index];
                            productId = productsAndCategories?.listOfProducts[index].id;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                color: Color(0xffF2F7F6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Container(width: MediaQuery.of(context).size.width / 3,
                                              height: MediaQuery.of(context).size.height / 6,
                                              child: product?.foto_producto != null ? Image.network('https://hbtknet.com/storage/notes/${product?.foto_producto}', fit: BoxFit.fill,)
                                                  : Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width / 3,
                                              height: MediaQuery.of(context).size.height / 6,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [


                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => AdminEditProduct(selectedproduct:
                                                                  productsAndCategories?.listOfProducts[index],
                                                              categoryList: productsAndCategories?.listOfCategories,
                                                            ),
                                                        ),
                                                        );
                                                        },
                                                      icon: Icon(Icons.edit, size: 20,)),



                                                  IconButton(onPressed: () async {String message = await ProductUploadingAndDispalyingFunctions().
                                                            deleteProduct(productsAndCategories?.listOfProducts[index].id ?? 0);
                                                        Navigator.of(context).pop();
                                                        Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                                                        showMessage(context, message);},
                                                      icon: Icon(Icons.delete, size: 20,)),],)),],),
                                      SizedBox(height: 10.0,),
                                      Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height / 4,
                                        decoration: BoxDecoration(
                                            // border: Border.all(width: 2, color: Colors.blueGrey),
                                            // borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: productAttributes(),
                                      ),

                                      SizedBox(height: 6,)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                )
                    : SplashScreen())
          ],
        ),
      ),
    ));
  }
}
