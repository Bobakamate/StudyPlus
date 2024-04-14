import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manform/Provider/AppProvider.dart';

import '../../../SQlite/data.dart';


class CoursDetail extends StatefulWidget {
  const CoursDetail({super.key});

  @override
  State<CoursDetail> createState() => _CoursDetailState();
}

class _CoursDetailState extends State<CoursDetail> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState(){

    super.initState();
  }
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Image.asset(AppProvider.coursDetail.image,
              height: 300,
               fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 1500,
            width: MediaQuery.of(context).size.width,),
            Positioned(

                top: 10 + 250,
              child:  Container(
                height: 1500,
                width: MediaQuery.of(context).size.width,

                padding: EdgeInsets.only(left: 10,
                  right: 10,top: 10),
                decoration: BoxDecoration(
                  color: Color(0xff674dde),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),



                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(AppProvider.coursDetail.nom,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("prof : "+ AppProvider.coursDetailProf.nom,style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Description:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(AppProvider.coursDetail.description,style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),



                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: getCoursForModule(AppProvider.coursDetail.id!).length,
                        shrinkWrap: true,


                        itemBuilder: (context, index){
                          return Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                              Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 100,
                                  child:Text(getCoursForModule(AppProvider.coursDetail.id!)[index].nom, overflow :TextOverflow.ellipsis , maxLines : 1, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),

                                GestureDetector(
                                  onTap: (){
                                    Fluttertoast.showToast(msg: "Lancement du telechargeement");
                                    showNotification();
                                  },
                                  child: Icon(Icons.download),
                                ),
                                ]),
                                SizedBox(height: 10,),
                                  Container(
                                     alignment: Alignment.centerLeft,
                                    height: 50,
                                    width: MediaQuery.of(context).size.width - 10,

                                    child:Text(getCoursForModule(AppProvider.coursDetail.id!)[index].resume,

                                      overflow :TextOverflow.ellipsis,  maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 16)
                                      ,),

                                  )
                              ],

                            ),
                          );
                        })
                  ],
                ),
              )
              ) ,


          ],
        ),
      ),
    );
  }

  static List<Cours> getCoursForModule(int idModule) {
    // Filtrer la liste courChapitres pour les cours du module donné
    return AppProvider.courChapitres.where((cours) => cours.idModule == idModule).toList();
  }



   Future<void> initializeNotifications() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        // Ajoutez ici la logique à exécuter lorsque l'utilisateur appuie sur la notification
      },
    );
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'simple_notification_channel', // Identifiant du canal de notification
      'Simple Notification Channel', // Nom du canal de notification
      channelDescription: 'Channel for simple notifications', // Description du canal de notification
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
// Définir les détails de la notification pour toutes les plateformes
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

// Afficher la notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
      payload: 'notification_payload',
    );

}
}
