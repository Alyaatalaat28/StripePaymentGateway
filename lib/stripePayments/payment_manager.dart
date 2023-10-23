import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_gateway/stripePayments/stripe_keys.dart';

abstract class PaymentManager{

  static Future<void>paymentManager(int amount,String currency)async{
       try{
         String clientSecret= await getClientSecret((amount*100).toString(),currency);
         await initializePaymentSheet(clientSecret);
         await Stripe.instance.presentPaymentSheet();
       }catch(error){
        throw Exception(error.toString());
       }
   }
  static Future<void> initializePaymentSheet(String clientSecret)async{
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:clientSecret ,
            merchantDisplayName: 'alyaa',
          ),
          );
   }


  static Future<String> getClientSecret(String amount,String currency)async{
       Dio dio=Dio();
      var response= await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiKeys.secretKey}',
           'Content-Type': 'application/x-www-form-urlencoded'
          }, 
        ),
        data: {
        'amount': amount,
        'currency': currency,
        }
       );
       return response.data['client_secret'];
   }

}