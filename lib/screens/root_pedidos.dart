import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/admin_get_all_orders.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/screens/pedidos_al_domicilio.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';

import 'pedidos_en_la_tienda.dart';

class ForkPedidosTiendaDomicilio extends StatefulWidget {
  static const String id = '/ForkPedidosTiendaDomicilio';
  const ForkPedidosTiendaDomicilio({Key? key}) : super(key: key);

  @override
  _ForkPedidosTiendaDomicilioState createState() => _ForkPedidosTiendaDomicilioState();}
class _ForkPedidosTiendaDomicilioState extends State<ForkPedidosTiendaDomicilio> {




  @override
  Widget build(BuildContext context) {



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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                   // color: Colors.grey,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            'Pedidos ',
                            style: TextStyle(fontSize: 24),
                          )),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(thickness: 2,color: Colors.amber,),
              ),
              Expanded(
                child: ListView(



                    children: [

                      UsedWidgets().buildListTile(leadingIcon:Icons.storefront_sharp,
                        voidCallback: (){Navigator.of(context).pushNamed(PedidosEnLaTienda.id);},title: 'En la Tienda',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.delivery_dining ,
                        voidCallback: () async{Navigator.of(context).pushNamed(PedidosAldomicilio.id);
                        },title: 'Al Domicilio ',),


                    ],
                    ),
              )
            ],
          ),
        ));
  }
}
