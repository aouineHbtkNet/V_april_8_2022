import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/apis/admin_get_all_orders.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:http/http.dart' as http;

class GetPedidosProvider extends ChangeNotifier {

  int id=0;
  getId( int num ) async {
    id =num;
  }

  //========================date section=================== Start ===============================
  DateTime  fromDate = DateTime.now().subtract(Duration(days:1));
  DateTime  toDate = DateTime.now().add(Duration(days:1));

  pickStartDate(BuildContext context) async {
    await pickDateStart(context);
    notifyListeners();
  }
  pickEndtDate(BuildContext context) async {
    await pickDateEnd(context);
    notifyListeners();
  }

  Future  pickDateStart( BuildContext context ) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: fromDate ,
        firstDate:DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5) );
    if(newDate==null)return;
    fromDate= newDate;
    await  getDifference();
    await getDurationInDayse;
    notifyListeners();
  }

  Future  pickDateEnd( BuildContext context ) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: toDate ,
        firstDate:DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5) );
    if(newDate==null)return;
    toDate= newDate;
    await  getDifference();
    await getDurationInDayse;
    notifyListeners();
  }
  int _durationInDays =0 ;
  int get getDurationInDayse =>_durationInDays;
  getDifference(){
    _durationInDays = fromDate.difference(toDate).inDays.abs();}



  List<dynamic> _listOfordersTable  =[];
  List<dynamic> get geLlistOforderstable =>_listOfordersTable;
   getAllOrderList () async {

    _listOfordersTable =  await GetAllOrdersAdmin().getOrdersAdmin();
     await  getDifference();
     await getDurationInDayse;
     await   refreshAtStore();
    await refreshAlDomicilio();
     notifyListeners();
  }

  refreshAtStore() async{
    await  getAtStoreReceived ();
    await  getAtStoreBeingPrepared ();
    await  getAtStoreReady ();
    await   getAtStoreDelivered ();
    await  getAtStorePendientes ();
  }


  List<dynamic> _atStoreReceived  =[];
   List<dynamic> get atStoreReceived => _atStoreReceived;
  getAtStoreReceived ()  async {
    _atStoreReceived =  _listOfordersTable.where( (order) =>
    order['manera_entrega']=='A la tienda').where((order) => order['status']=='Recibido').
    where((order) =>  DateTime.parse( order['created_at']).isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }

  List<dynamic>_atStoreBeingPrepared  =[];
  List<dynamic> get atStoreBeingPrepared =>_atStoreBeingPrepared;

  getAtStoreBeingPrepared ()  async {
    _atStoreBeingPrepared  =  await  _listOfordersTable.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='En preparacion').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }

  List<dynamic>_atStoreReady  =[];
  List<dynamic> get atStoreReady  =>_atStoreReady;

  getAtStoreReady ()  async {
    _atStoreReady =  await  _listOfordersTable.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Listo').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


  List<dynamic>_atStoreDelivered =[];
  List<dynamic> get atStoreDelivered =>_atStoreDelivered;

  getAtStoreDelivered ()  async {
    _atStoreDelivered= await  _listOfordersTable.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Entregado').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


  List<dynamic>_atStorePendientes =[];
  List<dynamic> get atStorePendientes =>_atStorePendientes;

  getAtStorePendientes()  async {
    _atStorePendientes= await _listOfordersTable.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Pendiente').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


  refreshAlDomicilio() async{
    await getAldomicilioReceived();
    await  getAldomicilioBeingprepared ();
    await   getAldomicilioEnacmino ();
    await  getAldomicilioDelivered  ();
    await  getAldomicilioPendientes ();
  }




  List<dynamic>_aldomicilioReceived =[];
  List<dynamic> get aldomicilioReceived=>_aldomicilioReceived;
  getAldomicilioReceived ()  async {
    _aldomicilioReceived =  await _listOfordersTable.where((order) => order['manera_entrega']=='Al domicilio'). where((order) => order['status']=='Recibido').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


  List<dynamic>_aldomicilioBeingprepared =[];
  List<dynamic> get aldomicilioBeingprepared =>_aldomicilioBeingprepared;

  getAldomicilioBeingprepared ()  async {
    _aldomicilioBeingprepared  =  await _listOfordersTable.where((order) => order['manera_entrega']=='Al domicilio'). where((order) => order['status']=='En preparacion').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }

  List<dynamic>_aldomicilioEnacmino  =[];
  List<dynamic> get aldomicilioEnacmino  =>_aldomicilioEnacmino;

  getAldomicilioEnacmino()  async {
    _aldomicilioEnacmino =  await _listOfordersTable.where((order) => order['manera_entrega']=='Al domicilio'). where((order) => order['status']=='En Camino').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


  List<dynamic>_aldomicilioDelivered =[];
  List<dynamic> get aldomicilioDelivered =>_aldomicilioDelivered;

  getAldomicilioDelivered ()  async {
    _aldomicilioDelivered = await  _listOfordersTable.where((order) => order['manera_entrega']=='Al domicilio'). where((order) => order['status']=='Entregado').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }



  List<dynamic>_aldomicilioPendientes =[];
  List<dynamic>get  aldomicilioPendientes =>_aldomicilioPendientes;

  getAldomicilioPendientes()  async {
    _aldomicilioPendientes = await  _listOfordersTable.where((order) => order['manera_entrega']=='Al domicilio'). where((order) => order['status']=='Pendiente').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }









































  List<dynamic>_listOfOrderItems  =[];
  List<dynamic> get listOfOrderItems =>_listOfOrderItems;

  getOrderWithDetailLisNoFilter()  async {
    _listOfOrderItems = await GetAllOrdersAdmin().getOrderWithDetailsAdminNoFilter();
      listOfOrderItems;
    notifyListeners();
  }


//==============================================================================================





  //=========================STATUS =====> EN LA TIENDA=====> 5 STATUS : 1-Recibidos   2-En Preparación  3-Listos   4-Entregados    5-Pendientes
  // ========================================================================1-Recibidos ======================


















//=====================================================Filtering with api start ============
  List<dynamic>_orderswithDetailsListFiltered  =[];
  List<dynamic> get orderswithDetailsListFiltered =>_orderswithDetailsListFiltered;

  getOrderWithDetailList (int id) async {
    _orderswithDetailsListFiltered =  await GetAllOrdersAdmin().getOrderWithDetailsAdmin(id);
    notifyListeners();
  }

//======================================== Filtering with api end============================================







  List<dynamic>_selectedOrderById =[];
  List<dynamic> get selectedOrderById =>_selectedOrderById;


  getselectedOrderById()  async {
    _selectedOrderById= await listOfOrderItems.where((order) => order['order_id']==id).toList();
    notifyListeners();
  }



//
// init() async{
//    _allOrders=[];
//    _ordersList =  await GetAllOrdersAdmin().getOrdersAdmin();
//    notifyListeners();
// }





























}