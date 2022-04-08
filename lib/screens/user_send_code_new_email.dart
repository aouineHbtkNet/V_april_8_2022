import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/forget_password_users.dart';
import 'package:simo_v_7_0_1/apis/set_get_sharedPrefrences_functions.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/user_register_new_users.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';


class SendCodeandnewEmail extends StatefulWidget {
  static const String id = '/SendCodeandnewEmail';



  @override
  _SendCodeandnewEmailState createState() => _SendCodeandnewEmailState();
}


class _SendCodeandnewEmailState extends State {


  TextEditingController _codeController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController  _confirmPasswordController = TextEditingController();



  final _formKeySendCodepassword = GlobalKey<FormState>();
  bool isLoading =false;

  var args;
  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)!.settings.arguments ;

    print ('args----------------$args');

    final provider = Provider.of<ProviderOne>(context);
    return  args==null?CircularProgressIndicator(): Scaffold(
      body: SafeArea(

        child: Form(
            key:_formKeySendCodepassword,
            child: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height: 60,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color:Color(0xFF329932), spreadRadius: 10)
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/app_logo.png'),
                            fit: BoxFit.cover,
                          ),),),
                    ),


                    SizedBox(height: 40,),



                    Text('Ingresar tu email nuevo', style:
                    TextStyle(fontSize: 20, color: Color(0xFF00007f)  ),
                    ),
                    SizedBox(height: 40,),



                    TextFormField(
                      keyboardType: TextInputType.number, textInputAction: TextInputAction.done,
                      controller: _codeController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else if (value.isEmpty || value.length<6) {return "Entrada invalida.Ex: 111111";}
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Ingresar el codigo enviado a tu email', label: Text('Codigo enviado',
                        style: TextStyle(fontSize: 20,color: Color(0xFF00007f) ),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                    SizedBox(height: 40,),

                    TextFormField(
                      keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                      controller: _newPasswordController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else if (value.isEmpty || value.length<4) {return "Entrada invalida.Ex: password must have more than 4 in length";}
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Ingresar tu  nuevo contrasena', label: Text('contrasena nueva',
                        style: TextStyle(fontSize: 20,color: Color(0xFF00007f) ),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                    SizedBox(height: 40,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                      controller: _confirmPasswordController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else if (_confirmPasswordController.text!=_newPasswordController.text){ return 'contraseña y confirmación no coinciden'; }
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Confirmar la contraseña', label: Text('Confirmar la contraseña',
                        style: TextStyle(fontSize: 20, color: Color(0xFF00007f) ),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),










                    TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40.0),
                          shape: StadiumBorder()),
                      child: isLoading==true? CircularProgressIndicator():
                      Text(' Enviar ', style: TextStyle(fontSize: 24,color: Color(0xFF00007f) )),
                      onPressed:() async{
                        if( _formKeySendCodepassword.currentState!.validate()) {

                          setState(() {isLoading=true;});

                          LoginResponseDataModel userLoginResponse = LoginResponseDataModel();
                          userLoginResponse = await ForgetPassword().InsertCodeAndNewPassword(
                              email: args,
                              code: _codeController.text,
                              newPassword: _newPasswordController.text);


                            await provider.addTableToSPA('user');
                            await provider.addTokenToSPA(userLoginResponse.token);
                            await provider.addUserIdToSPA(userLoginResponse.id);
                            await provider.addUserNameToSPA(userLoginResponse.name);
                            await provider.addUserEmailToSPA(userLoginResponse.email);
                            setState(() {isLoading=false;});
                            Navigator.pushNamed(context, UserCatalogue.id);
                            setState(() {isLoading=false;});
                            showstuff(context, 'Hola ${userLoginResponse.name}, cambiaste tu contrasena con exito  ' );







                        }
                      },
                    ),


                    SizedBox(height: 10,),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40.0),
                          shape: StadiumBorder()),
                      child: Text('¿Tienes una cuenta?', style: TextStyle(fontSize: 16 , color: Color(0xFF00007f) ),),
                      onPressed:() async{Navigator.pushNamed(context, LoginScreen.id);},
                    ),


                    TextButton(
                      onPressed:() async{Navigator.pushNamed(context, RegisterNewUsers.id);},

                      child: Text('¿ Quieres crear una cuenta nueva?', style: TextStyle(fontSize: 16 ,color: Color(0xFF00007f) ),),
                    ),


                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  //notification alert widget
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
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushNamedAndRemoveUntil(DisplayProductsToBeEdited.id, (Route<dynamic> route) => false);
                    // context.read<ProviderTwo>().initialValues();
                    // await context.read<ProviderTwo>().bringproductos();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

}


