import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_camino.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_preparacion.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_entregados.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_pendientes.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_receivedos.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_en_preparacion%20.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_entregados.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_listo.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_pendientes.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_recibidos.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';

class PedidosAldomicilio extends StatefulWidget {
  static const String id = '/PedidosAlDomicilio';
  const PedidosAldomicilio({Key? key}) : super(key: key);

  @override
  _PedidosAldomicilioState createState() => _PedidosAldomicilioState();
}

class _PedidosAldomicilioState extends State<PedidosAldomicilio> {

  @override
  void initState() {
    context.read<GetPedidosProvider>().getAllOrderList();
    super.initState();
  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    List list = context.watch<GetPedidosProvider>().geLlistOforderstable;


    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),

              Row( mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.delivery_dining ,size: 60,color: Colors.amberAccent,),

                  GestureDetector(
                    onTap:()async{
                      setState(() {isLoading=true;});
                      await  context.read<GetPedidosProvider>().getAllOrderList();
                      setState(() {isLoading=false;});},

                    child:isLoading==true? CircularProgressIndicator():
                    Icon(Icons.refresh ,size: 40,color: Colors.green,),
                  )

                ],),
              Divider(thickness: 2,),
              Expanded(
                child: list.length==0?Center(child: Text('Cargando...',style: TextStyle(fontSize: 20),)): ListView(
                    children: <Widget>[
                      UsedWidgets().buildListTile(leadingIcon:Icons.label,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosRecividosDomicilio.id) ;  },
                          title:' Recibidos  ' , trailing:'${ context.watch<GetPedidosProvider>().aldomicilioReceived.length}' ),
                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.label,
                          voidCallback: (){ Navigator.of(context).pushNamed(PedidosEnPreparcionDomicilio.id) ;    },
                          title:'En Preparación' , trailing:'${ context.watch<GetPedidosProvider>().aldomicilioBeingprepared.length}' ),
                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.label,
                          voidCallback: (){ Navigator.of(context).pushNamed(PedidosEncaminoDomicilio.id) ;    },
                          title:'En Camino  ' , trailing:'${ context.watch<GetPedidosProvider>().aldomicilioEnacmino.length}' ),
                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.label,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosEntregadosDomicilio.id) ;    },
                          title:'Entregados' , trailing:'${ context.watch<GetPedidosProvider>().aldomicilioDelivered.length}' ),

                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.label,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosPendientesDomicilio.id) ;    },
                          title:'Pendientes' , trailing:'${ context.watch<GetPedidosProvider>().aldomicilioPendientes.length}' ),

                      Divider(thickness: 2,),



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.grey, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              onPressed: ()=>context.read<GetPedidosProvider>(). pickStartDate(context), child:
                            Text( 'Start date: ${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').year}-'
                                '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').month}-'
                                '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').day}',
                              style:TextStyle(fontSize: 20),)
                              ,)),
                            SizedBox(width: 10,),
                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              onPressed: ()=>context.read<GetPedidosProvider>(). pickEndtDate(context),
                              child: Text( 'End date: ${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').year}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').month}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').day}',
                                style:TextStyle(fontSize: 20),),)),
                          ],),) ,
                      Divider(thickness: 2,color: Colors.blueGrey,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, child: Row( children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Duracion : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                        ),
                        Text(' Ultimos ${context.watch<GetPedidosProvider>().getDurationInDayse} dias',style: TextStyle(fontSize: 24),),],),
                      ),
                      Divider(thickness: 2,color: Colors.blueGrey,),



                    ]),
              ),
            ],
          ),
        )
    );
  }
}



