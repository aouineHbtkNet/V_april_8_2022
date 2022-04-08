import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/screens/admin_edit_product.dart';
import 'package:simo_v_7_0_1/screens/error_screen.dart';
import 'package:simo_v_7_0_1/screens/order_details_screen.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_recibidos.dart';
import 'package:simo_v_7_0_1/screens/user_send_code_new_email.dart';
import 'package:simo_v_7_0_1/screens/webpage_mercadopago.dart';

class RouteGenerator {


//   Navigator.push(context,
//   MaterialPageRoute(builder:
//   (context)=>UserOrdersDetailsScreen (
//   selectedOrder:ordersList[index],
//   ),
//   ),
//   );
// },

  static Route<dynamic> generateRoute(RouteSettings settings) {

    if (settings.name == AdminEditProduct.id) {

            Product? product =Product();
            List<Category>? listOfCategories =[];

            product  = settings.arguments as Product?;
            listOfCategories = settings.arguments as List<Category>? ;

   var data  = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AdminEditProduct(selectedproduct: product,categoryList: listOfCategories,),
      );
    }

    if (settings.name == UserOrdersDetailsScreen.id) {
      var data  = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserOrdersDetailsScreen(selectedOrder: data,),
      );
    }


    if (settings.name == WebPageMercadoPago.id) {
      var data  = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserOrdersDetailsScreen(selectedOrder: data,),
      );
    }







    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }




}

