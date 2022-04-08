import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/image_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/user_app_bar.dart';

import 'cart_screen.dart';

class SelectedProductDetails extends StatefulWidget {
  const SelectedProductDetails({Key? key}) : super(key: key);
  static const String id = '/ selectedProductDetails';
  @override
  _SelectedProductDetailsState createState() => _SelectedProductDetailsState();
}

void showstuff(context, var myString) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: myString == '' || myString == null
              ? ClipRect(
                  child: Image.asset('assets/iconPlaceholder12.png'),
                )
              : ClipRect(
                  child: Image.network(
                      'https://hbtknet.com/storage/notes/$myString'),
                ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('Ok')))
          ],
        );
      });
}

var selectedProduct;
int quantityLocal = 1;

class _SelectedProductDetailsState extends State<SelectedProductDetails> {
  @override
  Widget build(BuildContext context) {
    selectedProduct = ModalRoute.of(context)!.settings.arguments as Product;
    var mymap = context.watch<ShoppingCartProvider>().collectionMap;




    return selectedProduct == null
        ? Text('Loading')
        : Scaffold(
            body: SafeArea(

            child: Column(
             mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,


                children: [

              Expanded(
                flex: 1,

                child: PopUpMenuWidgetUsers(putArrow: true, showcart: true, callbackArrow: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(UserCatalogue.id, (Route<dynamic> route) => false);},
                  voidCallbackCart: () {Navigator.of(context).pushNamedAndRemoveUntil(UserCart.id, (Route<dynamic> route) => false);},),
              ),

              Expanded(
                flex: 10,

                 child: Stack(
                   alignment: Alignment.topCenter,
                    children: [
                      
                      
                      Container(
                        height:400,
                        child: ImagewidgetNoButton(networkImageUrl: selectedProduct.foto_producto,),
                      ),
                  DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      maxChildSize: 0.8,
                      minChildSize: 0.4,
                      builder:(context,controller)=>Container(
                      color: Colors.white,
                      child: ListView(
                      controller: controller,
                     children: [
                       UsedWidgets().addtocartWidget(context, selectedProduct),
                      UsedWidgets().buildSelectedProduct(title: 'Categoria', data: '${selectedProduct.marca}'),
                      UsedWidgets().buildSelectedProduct(title: 'Marca', data: '${selectedProduct.marca}'),
                      UsedWidgets().buildSelectedProduct(title: 'Nombre', data: '${selectedProduct.nombre_producto}'),
                      UsedWidgets().buildSelectedProduct(title: 'Contenido', data: '${selectedProduct.nombre_producto}'),
                      UsedWidgets().buildSelectedProduct(title: 'Precio', data: '${selectedProduct.precio_ahora}\$' ),
                      selectedProduct.precio_anterior == null ? Text('') : UsedWidgets().buildSelectedProduct(title: 'precio antes',
                          data: '${selectedProduct.precio_anterior}\$' ), selectedProduct.precio_anterior == null
                          ? Text('') : UsedWidgets().buildSelectedProduct(title: 'Descuento', data: '${selectedProduct.porciento_de_descuento}\%'),
                      UsedWidgets().buildSelectedProduct(title: 'descripcion', data: '${selectedProduct.descripcion}' ),
                     ],
                    ),
                  )),

                  ],
                ),
              ),
              // Expanded(flex: 1,child: UsedWidgets().addtocartWidget(context, selectedProduct)),
            ]),
          ));
  }
}
