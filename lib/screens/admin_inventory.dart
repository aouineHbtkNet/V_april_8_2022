import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'admin_show_products_edit_delet.dart';
class AdminInventory extends StatelessWidget {
  static const String id = '/admininventory';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),

                UsedWidgets().buildListTile(leadingIcon: Icons.add,
                    voidCallback: (){Navigator.pushNamed(context, AdminAddProduct.id);},title: 'anadir un producto nuevo'),
                UsedWidgets().buildListTile(leadingIcon: Icons.edit,voidCallback: (){Navigator.pushNamed(context, AdminShowProductsEditDelete.id);},title: 'Editar y borrar productos'),
                UsedWidgets().buildListTile(leadingIcon: Icons.graphic_eq_outlined,voidCallback: (){},title: 'Estadísticas'),

              ]
          ),
        )
    );
  }
}
