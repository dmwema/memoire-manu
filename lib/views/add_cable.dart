import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/form/form_field.dart';

class AddCableView extends StatefulWidget {
  const AddCableView({Key? key}) : super(key: key);

  @override
  State<AddCableView> createState() => _AddCableViewState();
}

class _AddCableViewState extends State<AddCableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ajouter un bracelet", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, size: 18,)
                  )
                ],
              ),
              const SizedBox(height: 20,),
              CustomFormField(label: "ID du bracelet", hint: "Entrez l'ID du bracelet", password: false),
              const SizedBox(height: 15,),
              CustomFormField(label: "Nom du bracelet", hint: "Donnez un nom au bracelet", password: false),
              const SizedBox(height: 20,),
              Center(
                child: RoundedButton(title: "Enrégistrer", loading: false, onPress: () {

                }),
              )
            ],
          ),
        )
    );
  }
}