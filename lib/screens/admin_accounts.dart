import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'admin_add_new_admins.dart';
import 'admin_show_products_edit_delet.dart';


class AdminManagingAccounts extends StatelessWidget {
  static const String id = '/adminMangingAccounts';
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderOne>(context);
    return Scaffold(

        body: SafeArea(



          child: Column(
            children: [
              PopUpMenuWidgetAdmins(
                putArrow: true,
                callbackArrow: () {
                  Navigator.of(context).pop();
                },
              ),


              Expanded(
                child: ListView(

                  //  shrinkWrap: true,

                    children: <Widget>[

                      UsedWidgets().buildListTile(leadingIcon: Icons.add,
                          voidCallback: (){},title: 'anadir un administrador nuevo'),
                      UsedWidgets().buildListTile(leadingIcon: Icons.edit,
                          voidCallback: (){},title: 'Editar y borrar administradores'),

                      UsedWidgets().buildListTile(leadingIcon: Icons.add,
                          voidCallback: (){},title: 'anadir un usuarior nuevo'),
                      UsedWidgets().buildListTile(leadingIcon: Icons.edit,
                          voidCallback: (){},title: 'Editar y borrar usuarios'),
                      UsedWidgets().buildListTile(leadingIcon: Icons.graphic_eq_outlined,voidCallback: (){},title: 'Estadísticas'),













                    ]
                ),
              ),
            ],
          ),
        )
    );
  }
}
