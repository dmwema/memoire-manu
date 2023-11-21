import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/config/custom_appbar.dart';
import 'package:manu/resource/components/form/form_field.dart';
import 'package:manu/resource/config/colors.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _shortController = TextEditingController();

  AppViewModel appViewModel = AppViewModel();
  Map? account;

  List data = [];

  @override
  void initState() {
    appViewModel.getAccount().then((value) {
      setState(() {
        account = value;
      });
    });
    appViewModel.getContacts().then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Mes contact",
          showBack: true,
        ),
        floatingActionButton:InkWell(
          onTap: () {
            // Navigator.pushNamed(context, RoutesName.addCable);
            showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
              return Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Ajouter un contact", style: TextStyle(
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
                      CustomFormField(label: "Nom du contact", controller: _nameController, hint: "Donnez un nom du contact", password: false),
                      const SizedBox(height: 15,),
                      CustomFormField(label: "Téléphone", controller: _phoneController, hint: "Entrez le numéro de téléphone", password: false),
                      const SizedBox(height: 15,),
                      Center(
                        child: RoundedButton(title: "Enrégistrer", loading: false, onPress: () {
                          if (_nameController.text == '') {
                            Utils.flushBarErrorMessage("Vous devez donner un nom au contact", context);
                          } else if (_phoneController.text == '') {
                            Utils.flushBarErrorMessage("Vous devez entrer le numéro de téléphone du contact", context);
                          } else if (_nameController.text.length < 3) {
                            Utils.flushBarErrorMessage("Le nom doit avoir au mois 2 carractères", context);
                          } else {
                            String short = '';
                            if (_nameController.text.split(' ').length > 1) {
                              short = _nameController.text[0][0];
                            } else {
                              short = _nameController.text.substring(0, 2);
                            }
                            Map contact = {
                              'name': _nameController.text,
                              'phone': _phoneController.text,
                              'short': short
                            };
                            appViewModel.addContacts(contact).then((value) {
                              if (value) {
                                appViewModel.getContacts().then((value) {
                                  setState(() {
                                    data = value;
                                  });
                                });
                                Utils.toastMessage("Contact ajouté avec succès");
                                Navigator.pop(context);
                              }
                            });
                          }
                        }),
                      )
                    ],
                  )
              );
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.add, color: Colors.white, size: 26,),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Text("Liste de contact à contacter en cas de danger", style: TextStyle(
                fontSize: 12,
                color: Colors.black45
              ),),
              const SizedBox(height: 20,),
              if (data.isEmpty)
                const Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text("Aucun contact ajouté", style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              if (data.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Map current = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.primaryColor.withOpacity(.15),
                                child: Text(current['short'], style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor
                                ),),
                              ),
                              const SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(current['name'], style: const TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                  const SizedBox(width: 10,),
                                  Text(current['phone'], style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 9
                                  ),),
                                ],
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:  Stack(
                                      children: [
                                        Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, icon: const Icon(Icons.close)
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 5,
                                                      color: AppColors.primaryColor,
                                                    )
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.question_mark,
                                                    color: AppColors.primaryColor,
                                                    size: 50,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20,),
                                              Column(
                                                children: [
                                                  Text("Êtes-vous sûr de vouloir supprimer ${current['name']} de vos contacts ?", style: const TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ), textAlign: TextAlign.center,),
                                                ],
                                              ),
                                              const SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  RoundedButton(
                                                      title: "Confirmer",
                                                      loading: false,
                                                      onPress: () {
                                                        appViewModel.removeCable(current['pos']);
                                                        Navigator.pop(context);
                                                      }
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.close, size: 17, color: Colors.black54,)
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}