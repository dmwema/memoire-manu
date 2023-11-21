import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/config/hide_key_bord_container.dart';
import 'package:manu/resource/components/form/form_field.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';

class SetupView extends StatefulWidget {
  const SetupView({Key? key}) : super(key: key);

  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
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
                      child: Text("Allons-y !", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),),
                    ),
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: Image.asset("assets/setup.gif"),
                      ),
                    ),
                    CustomFormField(
                      label: "Votre nom complet",
                      hint: "Votre nom complet",
                      password: false,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10,),
                    CustomFormField(
                      label: "Votre numéro de téléphone",
                      hint: "Votre numéro de téléphone",
                      password: false,
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 20,),
                    Center(
                      child: RoundedButton(title: "Commencer", loading: false, onPress: () async {
                        if (_nameController.text == '') {
                          Utils.flushBarErrorMessage("Vous devez entrer votre nom", context);
                        } else if (_phoneController.text == '') {
                          Utils.flushBarErrorMessage("Vous devez entrer votre numéro de téléphone", context);
                        } else {
                          await appViewModel.updateAccount({
                            "name": _nameController.text,
                            "phone": _phoneController.text,
                            "message": "Alerte! ${_nameController.text} pourrait être en detresse"
                          }).then((value) {
                            if (value) {
                              Navigator.pushNamed(context, RoutesName.welcome);
                            }
                          });
                        }
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