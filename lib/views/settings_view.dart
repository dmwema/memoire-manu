import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/config/custom_appbar.dart';
import 'package:manu/resource/components/config/hide_key_bord_container.dart';
import 'package:manu/resource/components/form/form_field.dart';
import 'package:manu/resource/config/colors.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  AppViewModel appViewModel = AppViewModel();
  Map? account;

  @override
  void initState() {
    appViewModel.getAccount().then((value) {
      setState(() {
        account = value;
        if (account != null) {
          _nameController.text = account!['name'];
          _phoneController.text = account!['phone'];
          _messageController.text = account!['message'];
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyBordContainer(
      child: Scaffold(
          appBar: CustomAppBar(
            title: "Paramètres",
            showBack: true,
          ),
          floatingActionButton:InkWell(
            onTap: () async {
              await appViewModel.updateAccount({
                "name": _nameController.text,
                "phone": _phoneController.text,
                "message": _messageController.text
              }).then((value) {
                if (value) {
                  Utils.toastMessage("Informations mises à jour avec succès");
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(10),
              child: const Text("Enrégistrer", style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Text("Configurez votre compte", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45
                  ),),
                  const SizedBox(height: 20,),
                  CustomFormField(controller: _nameController, label: "Votre nom complet", hint: "Entrez votre nom complet", password: false),
                  const SizedBox(height: 15,),
                  CustomFormField(controller: _phoneController, label: "Votre numéro de téléphone", hint: "Entrez votre numéro de téléphone", password: false),
                  const SizedBox(height: 15,),
                  CustomFormField(controller: _messageController, label: "Message d'alerte", hint: "Entrez le message d'alerte", password: false, maxLines: 3,),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      AppViewModel().logout().then((value) {
                        if (value) {
                          Navigator.pushReplacementNamed(context, RoutesName.setupView);
                        }
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout_rounded, color: Colors.black, size: 13),
                            SizedBox(width: 3,),
                            Text("Se déconnecter", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 10
                            ),),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}