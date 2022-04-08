import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/modify_status.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/screens/pedidos_al_domicilio.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'admin_accounts.dart';
import 'admin_add_new_admins.dart';

import 'admin_inventory.dart';
import 'domicilio_tienda_opciones.dart';
import 'root_pedidos.dart';







class AdminDashBoard extends StatefulWidget {
  static const String id = '/ dashboardForAdmins';
  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}
class _AdminDashBoardState extends State<AdminDashBoard> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PopUpMenuWidgetAdmins(putArrow: false,),
              Expanded(
                child: Column(

                    children: <Widget>[
                      UsedWidgets().buildListTile(leadingIcon:Icons.food_bank,
                        voidCallback: (){Navigator.of(context).pushNamed(AdminInventory.id);},title: 'Inventario',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.account_box_outlined,
                        voidCallback: (){Navigator.of(context).pushNamed(AdminManagingAccounts.id);},title: 'Cuentas',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_outlined,
                        voidCallback: (){Navigator.of(context).pushNamed(ForkPedidosTiendaDomicilio.id);},title: 'Pedidos  ',
                     // trailing:'${screenListlengh}'


                      ),


                    ]),
              ),
            ],
          ),
        )
    );
  }
}
