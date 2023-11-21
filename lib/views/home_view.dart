import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';
import 'package:manu/view_model/location_service.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:manu/resource/components/config/hide_key_bord_container.dart';
import 'package:manu/resource/config/colors.dart';
import 'package:manu/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TwilioFlutter? twilioFlutter;
  LocationService locationService = LocationService();
  AppViewModel appViewModel = AppViewModel();
  Map? account;

  @override
  void initState() {
    locationService.requestPermission().then((value) {
      if (!value) {
        Utils.flushBarErrorMessage("Impossible d'accéder à la localisation du téléphone", context);
      }
    });

    twilioFlutter = TwilioFlutter(
        accountSid: 'AC656f2398f9f29ca485ba99c0ec590924',
        authToken: '74b5840e155d277a511b0775d15fcf54',
        twilioNumber: '+18339855006'
    );
    appViewModel.getAccount().then((value) {
      setState(() {
        account = value;
      });
    });
    super.initState();
  }

  bool sent = false;
  bool loading = false;

  Future<void> sendSms(String message, String phone) async {
    LocationData? locationData;
    await locationService.getCurrentLocation().then((value) {
      locationData = value;
    });

    if (locationData != null && account != null) {
      String url = 'https://www.google.com/maps/search/?api=1&query=${locationData!.latitude},${locationData!.longitude}';
      message += "\r\n\r\nCliquez sur le lien ci-dessous pour voir où " + account!['name'] + " se trouve.\r\n\r\n$url";
    } else {
      print("null data");
    }
    if (twilioFlutter != null) {
      await twilioFlutter!.sendSMS(
          toNumber: '+243852498766',
          messageBody: message
      );
      Utils.toastMessage("Alert envoyé avec succès");
      setState(() {
        sent = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyBordContainer(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 70),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    if (account != null)
                    Center(
                      child: Text("Bienvenue, ${account!['name']} !", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.primaryColor
                      ),),
                    ),
                    const SizedBox(height: 40,),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.contactView);
                      },
                      child: Container(
                         decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primaryColor
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Row(
                          children: [
                            Icon(Icons.contacts_outlined, color: Colors.white, size: 20,),
                            SizedBox(width: 20,),
                            Text("Mes contacts", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.cableView);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primaryColor
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Row(
                          children: [
                            Icon(Icons.circle_outlined, color: Colors.white, size: 20,),
                            SizedBox(width: 20,),
                            Text("Mes bracelet", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.settings);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primaryColor
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Row(
                          children: [
                            Icon(Icons.settings_outlined, color: Colors.white, size: 20,),
                            SizedBox(width: 20,),
                            Text("Paramètres", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60,),
                    if (sent)
                    InkWell(
                      onTap: () {
                        setState(() {
                          sent = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.grey)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal:10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh, size: 15,),
                            SizedBox(width: 10,),
                            Text("Actualiser", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ),
                    ),
                    if (sent)
                    const SizedBox(height: 20,),
                    if (account != null)
                    InkWell(
                      onTap: () async {
                        if (!sent && !loading) {
                          setState(() {
                            loading = true;
                          });

                          appViewModel.getContacts().then((value) async {
                            if (value.isEmpty) {
                              Utils.flushBarErrorMessage("Vous n'avez aucun contact à qui envoyer l'alerte. Enrégistrez des contacts premièrement", context);
                              setState(() {
                                loading = false;
                              });
                            } else {
                              value.forEach((element) async {
                                await sendSms(
                                account!['message'],
                                element['phone']
                                );
                              });
                            }
                          });

                        }
                      },
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.darkRed3
                          ),
                          child: Center(
                            child: Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.darkRed2
                              ),
                              child: Center(
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: sent ? Colors.green : AppColors.darkRed
                                  ),
                                  child: Center(child: loading ? const CircularProgressIndicator(color: Colors.white,) : Text(sent ? "Envoyé" : "SOS", style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}