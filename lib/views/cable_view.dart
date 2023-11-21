import 'package:flutter/material.dart';
import 'package:manu/resource/components/buttons/rounded_button.dart';
import 'package:manu/resource/components/config/hide_key_bord_container.dart';
import 'package:manu/resource/components/form/form_field.dart';
import 'package:manu/resource/config/colors.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/utils/utils.dart';
import 'package:manu/view_model/AppViewModel.dart';

class CableView extends StatefulWidget {
  const CableView({Key? key}) : super(key: key);

  @override
  State<CableView> createState() => _CableViewState();
}

class _CableViewState extends State<CableView> {
  AppViewModel appViewModel = AppViewModel();
  Map? account;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  List cables = [
    {
      'name': 'Bracelet 1',
      'id': '1234'
    },
    {
      'name': 'Bracelet 2',
      'id': '1235'
    },
    {
      'name': 'Bracelet 3',
      'id': '1236'
    },
  ];

  @override
  void initState() {
    appViewModel.getAccount().then((value) {
      setState(() {
        account = value;
      });
    });
    appViewModel.getCables().then((value) {
      setState(() {
        cables = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyBordContainer(
      child: Scaffold(
          backgroundColor: Colors.white,
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
                      CustomFormField(label: "Nom du bracelet", controller: _nameController, hint: "Donnez un nom du bracelet", password: false),
                      const SizedBox(height: 15,),
                      CustomFormField(label: "ID du bracelet", controller: _idController, hint: "Entre l'ID au bracelet", password: false),
                      const SizedBox(height: 20,),
                      Center(
                        child: RoundedButton(title: "Enrégistrer", loading: false, onPress: () {
                          if (_nameController.text == '') {
                            Utils.flushBarErrorMessage("Vous devez donner un nom au bracelet", context);
                          } else if (_idController.text == '') {
                            Utils.flushBarErrorMessage("Vous devez entrer l'ID du bracelet", context);
                          } else {
                            Map cable = {
                              'name': _nameController.text,
                              'id': _idController.text
                            };
                            appViewModel.addCable(cable).then((value) {
                              if (value) {
                                appViewModel.getCables().then((value) {
                                  setState(() {
                                    cables = value;
                                  });
                                });
                                Utils.toastMessage("Bracelet ajouté avec succès");
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
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 70),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.homeView);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Text("Mes bracelets", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.primaryColor
                  ),),
                ),
                if (cables.isEmpty)
                  const Column(
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, size: 20, color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text("Aucun bracelet connecté", style: TextStyle(
                              color: Colors.grey
                          ),)
                        ],
                      ),
                    ],
                  ),
                if (cables.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: cables.length,
                    itemBuilder: (context, index) {
                      Map current = cables[index];
                      return InkWell(
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
                                          child: IconButton(
                                              onPressed: (){
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
                                                Text("Êtes-vous sûr de vouloir supprimer ${current['name']} de vos bracelets ?", style: const TextStyle(
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
                                                      setState(() {
                                                        setState(() {
                                                          appViewModel.removeCable(current['pos']).then((value) {
                                                            if (value) {
                                                              appViewModel.getCables().then((value) {
                                                                setState(() {
                                                                  cables = value;
                                                                });
                                                              });
                                                            }
                                                          });
                                                        });
                                                      });
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.circle_outlined, color: Colors.white, size: 20,),
                                  const SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(current['name'], style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),
                                      Text("ID : ${current['id']}", style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(Icons.close, color: Colors.white,)
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 60,),
              ],
            ),
          )
      ),
    );
  }
}