import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/top_bar_widget_admins.dart';
import 'admin_show_products_edit_delet.dart';
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';

class AdminEditProduct extends StatefulWidget {
  static const String id = '/editproduct';
  Product?  selectedproduct;
  List<Category> ? categoryList;
  AdminEditProduct({  this.selectedproduct,  this.categoryList});
  @override
  _AdminEditProductState createState() => _AdminEditProductState();
}
class _AdminEditProductState extends State<AdminEditProduct> {
  final scaffoldKeyUnique = GlobalKey<ScaffoldState>();

  Widget categoryDropDown(){

    return  DropdownButtonFormField<String>(decoration: InputDecoration(hintText: 'Escoger la categoria',
      label: Text('Categoria', style: TextStyle(fontSize: 20, color: Colors.blue),),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
        value: selectedCategory.toString(),
        onChanged: (value) {setState(() {selectedCategory = value!;});},
        items: widget.categoryList?.map<DropdownMenuItem<String>>((value) =>
            DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.nombre_categoria.toString()))).toList());
  }


//ImagePicker
  File? imageFile;
  void pickupImage(ImageSource source) async {
    try {
      final imageFile = await ImagePicker().pickImage(source: source);

      if (imageFile == null) return;
      final imageTemporary = File(imageFile.path);
      setState(() {
        this.imageFile = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to pick up the image :$e');
    }
  }

  //Sheet function
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera_outlined),
                title: new Text('Camera'),
                onTap: () {
                  pickupImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo_library_outlined),
                title: new Text('Galeria'),
                onTap: () {
                  pickupImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }















  Widget buildImageContainer() {
    return Row(children: [Container(width: 120, height: 120,
        child: imageFile != null
            ? ClipRRect(borderRadius: BorderRadius.circular(20),


          child: Image.file(imageFile!, fit: BoxFit.fill,),)
            :widget. selectedproduct?.foto_producto != null
            ? ClipRRect(borderRadius: BorderRadius.circular(20),
              child: Image.network('https://hbtknet.com/storage/notes/${widget.selectedproduct?.foto_producto}',
              fit: BoxFit.fill),)
            : ClipRRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill),
        )
    ),
      SizedBox(width: 20,),
      IconButton(icon: Icon(Icons.edit), onPressed: () {showPicker(context);},),
      SizedBox(width: 20,),
    ],);}

  List taxTypesList = ['IVA', 'Impoconsumo', 'Exento'];
  final _formKeyEditpage = GlobalKey<FormState>();
  var selectedCategory;
  int?  productId;
  String? selectedTaxType;

  List<DropdownMenuItem<String>>? emptyList=[];

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerContenido = TextEditingController();
  TextEditingController controllerPorcientoDeImpuesto = TextEditingController(text: '0.0');
  TextEditingController controllerPrecio = TextEditingController(text: '0.0');
  TextEditingController controllerPrecioAntes = TextEditingController(text: '0.0');
  TextEditingController controllerDescripcion = TextEditingController();

  @override
  void dispose() {
    controllerNombre.dispose();
    controllerMarca.dispose();
    controllerContenido.dispose();
    controllerPorcientoDeImpuesto.dispose();
    controllerPrecio.dispose();
    controllerPrecioAntes.dispose();
    controllerDescripcion.dispose();
    super.dispose();
  }

  @override
  void initState() {
    productId  = widget.selectedproduct?.id;
    selectedCategory = widget.selectedproduct?.categoria_id ?? selectedCategory;
    controllerNombre.text =widget. selectedproduct?.nombre_producto ?? controllerNombre.text;
    controllerMarca.text = widget.selectedproduct?.marca ?? controllerMarca.text;
    controllerContenido.text =widget. selectedproduct?.contenido ?? controllerContenido.text;
    selectedTaxType = widget.selectedproduct?.typo_impuesto ?? selectedTaxType;
    controllerPorcientoDeImpuesto.text = widget.selectedproduct?.porciento_impuesto.toString() ?? controllerPorcientoDeImpuesto.text;
    controllerPrecio.text = widget.selectedproduct?.precio_ahora.toString() ?? controllerPrecio.text;
    controllerPrecioAntes.text = widget.selectedproduct?.precio_anterior.toString()?? controllerPrecioAntes.text;
    controllerDescripcion.text =widget. selectedproduct?.descripcion ?? controllerDescripcion.text;
    super.initState();
  }
  double valor_descuento = 0.0;
  double porciento_de_descuento = 0.0;
  double valor_impuesto = 0.0;
  double precio_sin_impuesto = 0.0;
  void calculateProductDynamicvalues({double precio_ahora = 0.0, double precio_anterior = 0.0, double porciento_impuesto = 0.0,
  }) {precio_anterior > 0 && precio_anterior > precio_ahora ? valor_descuento = precio_anterior - precio_ahora : 0.0;
    precio_anterior > 0 ? porciento_de_descuento = ((precio_anterior - precio_ahora) / precio_anterior) * 100 : 0.0;
    precio_anterior > 0 && porciento_impuesto > 0 ? valor_impuesto = precio_ahora * (porciento_impuesto / 100) : 0.0;
    precio_sin_impuesto = precio_ahora - valor_impuesto;
  }


  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SafeArea(
          child: Padding(padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
              PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),
              SizedBox(height: 20,),
              Expanded(
                child: Form(
                  key: _formKeyEditpage,
                  child: ListView(
                    children: [
                      SizedBox(height: 10,),
                     Text('${widget.selectedproduct?.id}'),
                      //SizedBox(height: 20,),
                      buildImageContainer(),
                      SizedBox(height: 20,),
                      categoryDropDown(),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre completo', textEditingController: controllerNombre),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Marca', textEditingController: controllerMarca),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Contenido', textEditingController: controllerContenido),
                      SizedBox(height: 20,),
                      UsedWidgets().buildDropDownButtonFixedList(valueInitial: selectedTaxType, label: 'Escoger el impuesto ',
                          onChanged: (value) {selectedTaxType = value!;}, list: taxTypesList),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForDoubleNoInitial(label: 'Porciento de impuesto', textEditingController: controllerPorcientoDeImpuesto,),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForDoubleNoInitial(label: 'Precio', textEditingController: controllerPrecio,),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForDoubleNoInitial(label: 'Precio antes', textEditingController: controllerPrecioAntes,),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Descripcion', textEditingController: controllerDescripcion,),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.teal),
                              padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
                          child:isLoading==true? CircularProgressIndicator() :Text('Enviar'),
                          onPressed: () async {


                            if (_formKeyEditpage.currentState!.validate()) {
                              _formKeyEditpage.currentState!.save();
                              setState(() {isLoading=true;});
                                           calculateProductDynamicvalues(
                                             porciento_impuesto:double.parse(controllerPorcientoDeImpuesto.text),
                                             precio_ahora:double.parse(controllerPrecio.text),
                                             precio_anterior:double.parse(controllerPrecioAntes.text),);
                              print ('valor_descuento ${valor_descuento}');
                              print ('porciento_de_descuento${porciento_de_descuento}');
                              print ('valor_impuesto ${valor_impuesto}');
                              print ('precio_sin_impuesto ${precio_sin_impuesto}');

                              if (imageFile != null) {
                                      String message = await ProductUploadingAndDispalyingFunctions().UpdateWithImage(
                                          imageFile!,
                                          product_id: productId.toString(),
                                          categoria_id:selectedCategory.toString(),
                                          nombre_producto:controllerNombre.text,
                                          marca:controllerMarca.text,
                                          contenido:controllerContenido.text,
                                           typo_impuesto:selectedTaxType??'',
                                          porciento_impuesto:controllerPorcientoDeImpuesto.text,
                                          valor_impuesto: valor_impuesto .toString(),
                                          precio_ahora:controllerPrecio.text,
                                          precio_sin_impuesto:precio_sin_impuesto .toString(),
                                          precio_anterior:controllerPrecioAntes.text,
                                          porciento_de_descuento:porciento_de_descuento.toString(),
                                          valor_descuento:valor_descuento.toString(),
                                          descripcion:controllerDescripcion.text
                                      );
                                      showstuff(context, message);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                                       setState(() {isLoading=false;});


                                  }else{
                                    String message = await ProductUploadingAndDispalyingFunctions().UpdateWithNoImage(
                                        product_id: productId.toString(),
                                        categoria_id:selectedCategory.toString(),
                                        nombre_producto:controllerNombre.text,
                                        marca:controllerMarca.text,
                                        contenido:controllerContenido.text,
                                        typo_impuesto:selectedTaxType??'',
                                        porciento_impuesto:controllerPorcientoDeImpuesto.text,
                                        valor_impuesto: valor_impuesto .toString(),
                                        precio_ahora:controllerPrecio.text,
                                        precio_sin_impuesto:precio_sin_impuesto.toString(),
                                        precio_anterior:controllerPrecioAntes.text,
                                        porciento_de_descuento:porciento_de_descuento.toString(),
                                        valor_descuento:valor_descuento.toString(),
                                        descripcion:controllerDescripcion.text
                                    );

                                    showstuff(context, message);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                                    setState(() {isLoading=false;});




                              }









                            }

                          },


                                ),
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    ),
        ));
  }

  void showstuff(context, String mynotification) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text(mynotification),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.popUntil(context, ModalRoute.withName(AdminShowProductsEditDelete.id));},
                  child: Text('Ok')),
            ],
          );
        });
  }
}

class ContainerOFimage extends StatelessWidget {
  var productos;
  File? file;

  ContainerOFimage({Key? key, required this.productos, required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 120,
          height: 120,
          child: file != null
              ? ClipOval(
                  child: Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
                )
              : productos[0]['foto_producto'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          'http://192.168.1.22/api_v_1/storage/app/public/notes/${productos[0]['foto_producto']}',
                          fit: BoxFit.fill),
                    )
                  : ClipRRect(
                      child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE,
                          fit: BoxFit.fill),
                    )),
    ]);
  }
}










// if (imageFile != null) {
//   String message =
//   await ProductUploadingAndDispalyingFunctions().UpdateWithImage(
//
//     idOfProduct!,
//     imageFile!,
//     selectedCategory == null && idOfCategory !=null ? '$idOfCategory' :
//     selectedCategory==null?'':selectedCategory!,
//     nombre==null?'':nombre!,
//     marca==null?'':marca!,
//     contenido==null?'':contenido!,
//     selectedTaxType == null && productos['typo_impuesto']!=null ? '${productos['typo_impuesto']}' :
//     selectedTaxType==null?'':selectedTaxType!,
//     porciento_impuesto==null?'':porciento_impuesto!,
//     Taxvalue.toString(),
//     precio_ahora ==null?'':precio_ahora !, price_with_no_tax.toString(),
//     selectedDiscuento == null ? 'no' : selectedDiscuento!,
//     precio_anterior==null?'':precio_anterior!,
//     discountinPercentage.toString(),
//     descripcion==null?'':descripcion!,
//
//   );
//   showstuff(context, message);
// } else {
//   String message =
//   await ProductUploadingAndDispalyingFunctions().UpdateWithNoImage(
//
//     idOfProduct!,
//     selectedCategory == null && idOfCategory !=null ? '$idOfCategory' :
//     selectedCategory==null?'':selectedCategory!,
//     nombre==null?'':nombre!,
//     marca==null?'':marca!,
//     contenido==null?'':contenido!,
//     selectedTaxType == null && productos['typo_impuesto']!=null ? '${productos['typo_impuesto']}' :
//     selectedTaxType==null?'':selectedTaxType!,
//     porciento_impuesto==null?'':porciento_impuesto!,
//     Taxvalue.toString(),
//     precio_ahora ==null?'':precio_ahora !, price_with_no_tax.toString(),
//     selectedDiscuento == null ? 'no' : selectedDiscuento!,
//     precio_anterior==null?'':precio_anterior!,
//     discountinPercentage.toString(),
//     descripcion==null?'':descripcion!,
//
//   );}

// showstuff(context, message);

