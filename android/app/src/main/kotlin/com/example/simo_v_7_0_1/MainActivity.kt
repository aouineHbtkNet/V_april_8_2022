
package com.hbtknet.simo_v_7_0_1

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
//import com.mercadopago.android.px.core.MercadoPagoCheckout.Builder;

class MainActivity: FlutterActivity() {
//val requestCode =1;
    private val methodChannelName = "channelForPayement";
    private lateinit var channel:MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel =MethodChannel(flutterEngine.dartExecutor.binaryMessenger,methodChannelName)
        channel.setMethodCallHandler { call, result ->




            var arguement =call.arguments as Map<String, String>
            var publickey =arguement["publickey"] as String
            var preferenceId =arguement["preferenceId"] as String

            var message = arguement["msg"]
            if(call.method=="showToast"){

                Toast.makeText(this,message,Toast.LENGTH_LONG).show()

                // MercadoPagoCheckout.Builder(publickey,preferenceId).build().startPayment( this@MainActivity, requestCode);


            }

        }
    }
}
