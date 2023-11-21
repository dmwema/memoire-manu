import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/config/hide_key_bord_container.dart';
import 'package:manu/resource/components/form/form_field.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => WelcomeViewState();
}

class WelcomeViewState extends State<WelcomeView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  AppViewModel appViewModel = AppViewModel();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text("Bienvenue !", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),
                    const SizedBox(height: 30,),
                    const Center(
                      child: SizedBox(
                        width: 300,
                        child: Text("Informez vos proches à chaque fois vous êtes en detresse", style: TextStyle(
                            fontSize: 14
                        ), textAlign: TextAlign.center,),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Text("Gestion des contacts", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                    const SizedBox(height: 10,),
                    const Text("Ajoutez les contacts que vous desirez alerter en cas de détresse ou supprimez ceux à qui vous ne voulez plus notifier. ", style: TextStyle(
                        fontSize: 12
                    ),),
                    const SizedBox(height: 20,),
                    const Text("Gestion des bracelets", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                    const SizedBox(height: 10,),
                    const Text("Ajoutez les bracelets pour alerter rapidement et discrètement vos contacts sans avoir à accéder à vôtre telephone ", style: TextStyle(
                        fontSize: 12
                    ),),
                    const SizedBox(height: 20,),
                    const Text("Paramètres", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                    const SizedBox(height: 10,),
                    const Text("Modifiez vos informations personnels et le message que vous comptez envoyer à vos contacts", style: TextStyle(
                        fontSize: 12
                    ),),
                    const SizedBox(height: 50,),
                    Center(
                      child: RoundedButton(title: "Commencer", loading: false, onPress: () {
                        Navigator.pushNamed(context, RoutesName.homeView);
                      }),
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