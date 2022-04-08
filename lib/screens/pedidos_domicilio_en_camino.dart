import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/modify_status.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';

class PedidosEncaminoDomicilio extends StatefulWidget {
  static const String id = '/PedidosEncaminoDomicilio';

  _PedidosEncaminoDomicilioState createState() => _PedidosEncaminoDomicilioState();}
class _PedidosEncaminoDomicilioState extends State<PedidosEncaminoDomicilio> {

  bool iSloadingPendiente =false;
  bool iSloadingChangeStatus =false;
  String? selectedStatus;
  @override
  void initState() {
    context.read<GetPedidosProvider>().getOrderWithDetailLisNoFilter() ;// get the orderitem table data
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    List allOrdersList= context.watch<GetPedidosProvider>().listOfOrderItems; // this is the list via calling the function in init state
    DateTime parsedstartTime =  DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}');
    DateTime parsedEndtTime =  DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}');
    List list = context.watch<GetPedidosProvider>().aldomicilioEnacmino;




    return Scaffold(
        body: SafeArea(child:Column(children: [
          PopUpMenuWidgetAdmins(putArrow: true, callbackArrow: () {Navigator.of(context).pop();},),
          Divider(thickness: 2,),
          UsedWidgets().buildListTileForTitle(leadingIcon:Icons.delivery_dining ,
              voidCallback: (){  Navigator.of(context).pushNamed(PedidosEncaminoDomicilio.id);}, title:'En Camino'  ),
          Divider(thickness: 2,),
          Padding(padding: const EdgeInsets.all(8.0),
              child: Container(width: double.infinity,
                child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text( 'Desde : ${parsedstartTime.year}-${parsedstartTime.month}-'
                        '${parsedstartTime.day}  hasta : ${parsedEndtTime.year}-${parsedEndtTime.month}-'
                        '${parsedEndtTime.day} ', style:TextStyle(fontSize: 16),))),)),
          Expanded(
            child: ListView.builder(itemCount:list.length,
                itemBuilder: (BuildContext context, int index) {return Padding(
                  padding: const EdgeInsets.all(8.0), child: Card(
                  // color: Color(0xffE3E3E3),
                  elevation: 20, child: Column(
                  children: [SizedBox(height: 10,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async{
                        setState(() {iSloadingPendiente=true;});
                        int orderId = list[index]['id'];
                        await ModifyStatus().modifySatatus(orderId,'Pendiente');
                        await context.read<GetPedidosProvider>().getAllOrderList();
                        setState(() {iSloadingPendiente=false;});
                      },
                      child:iSloadingPendiente==false? Text('Poner al pedido como Pendiente'):Text('cargando...'),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),




                    Text('${index+1}/${ list.length}',
                      style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),

                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row( children: [
                      Text(' Numero del pedido : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text('${list[index]['id']}',style: TextStyle(fontSize: 24),),],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text(' Cliente : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text(' ${list[index]['get_order_id_for_order_model']['name']}',style: TextStyle(fontSize: 24),),],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text('Direccion : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text(' ${list[index]['get_order_id_for_order_model']['address']}',style: TextStyle(fontSize: 24),),
                    ],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text('Cel : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text(' ${list[index]['get_order_id_for_order_model']['mobile_phone']}',style: TextStyle(fontSize: 24),),
                    ],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text(' Fecha : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text('${DateTime.parse(list[index]['created_at']).year }-'
                          '${DateTime.parse(list[index]['created_at']).month }-'
                          '${DateTime.parse(list[index]['created_at']).day }-'
                          '${DateTime.parse(list[index]['created_at']).hour }h-'
                          '${DateTime.parse(list[index]['created_at']).minute }min'
                        ,style: TextStyle(fontSize: 24),),],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text('Total a pagar  : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text(' ${list[index]['grand_delivery_fees_in']}\$',style: TextStyle(fontSize: 24),),
                    ],),
                    ),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Row(children: [
                      Text('Manera de pago  : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      Text(' ${list[index]['manera_pago']}',style: TextStyle(fontSize: 24),),
                    ],),),
                    Divider(thickness: 2,color: Colors.blueGrey,),
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: allOrdersList.length==0?Text('Cargando...'):
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xff009B77),
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: ()async {

                            int orderId = list[index]['id'];
                            List selectedOrder = allOrdersList.where((order) => order['order_id']==orderId).toList();
                            showModalBottomSheet(
                                isScrollControlled: true,
                                constraints:BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.7),
                                context: context,
                                builder: (context) {
                                  return ListView.builder(
                                    itemCount:selectedOrder.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          Divider(thickness: 2,color: Colors.blueGrey,),
                                          Text('  ${index+1}/${ selectedOrder.length}',
                                            style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),
                                          Divider(thickness: 2,color: Colors.blueGrey,),


                                          SizedBox(height: 10,),
                                          Padding(padding: const EdgeInsets.all(14.0),
                                            child: Container(
                                              height:200,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage( 'https://hbtknet.com/storage/notes/${selectedOrder[index]['product']['foto_producto']}'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text(' ID : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['product']['id']}',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),

                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text('Nombre: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['product']['nombre_producto']}',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),

                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text('Marca: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['product']['marca']}',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text('Contenido: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['product']['contenido']}',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),

                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text('Precio: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['product']['precio_ahora']}\$',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),

                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal, child: Row( children: [
                                            Text('Cantidad: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                            Text('${selectedOrder[index]['qty']}',style: TextStyle(fontSize: 24),),],),
                                          ),
                                          SizedBox(height: 10,),
                                          Text('Descripcion: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                          Text('${selectedOrder[index]['product']['descripcion']}',style: TextStyle(fontSize: 24),),
                                          SizedBox(height: 10,),
                                        ],); },
                                  );});},
                          child:Text('Ver el carito'),),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff009B77),
                                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            onPressed: () async{
                              setState(() {iSloadingChangeStatus=true;});
                              int orderId = list[index]['id'];
                              await ModifyStatus().modifySatatus(orderId,'Entregado');
                              await context.read<GetPedidosProvider>().getAllOrderList();
                              setState(() {iSloadingChangeStatus=false;});

                            },
                            child:iSloadingChangeStatus==false? Text('Entregar'):Text('cargando...'),
                          )],
                      ),
                    ),
                  ],
                ),
                ),
                );
                }),
          )
        ],
        ),
        ));
  }
}
