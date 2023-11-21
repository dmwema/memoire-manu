import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppViewModel with ChangeNotifier {
  Future<bool> updateAccount(Map data) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('account__name', data['name']);
    sp.setString('account__phone', data['phone']);
    sp.setString('account__message', data['message']);
    return true;
  }

  Future<Map?> getAccount() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? name = sp.getString('account__name');
    String? phone = sp.getString('account__phone');
    String? message = sp.getString('account__message');

    return {
      "name": name,
      "phone": phone,
      "message": message
    };
  }

  Future<List> getContacts() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List contacts = [];
    int? count = sp.getInt('contact__count');

    if (count != null && count > 0) {
      for (var i = 0; i < count; i++) {
        String? name = sp.getString("contact__${i+1}__name");
        String? phone = sp.getString("contact__${i+1}__phone");
        String? short = sp.getString("contact__${i+1}__short");
        int? pos = sp.getInt("contact__${i+1}__pos");
        if (name != null && phone != null && short != null) {
          contacts.add({
            'name': name,
            'phone': phone,
            'short': short,
            'pos': pos
          });
        }
      }
    }
    return contacts;
  }

  Future<bool> addContacts(Map value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    int? count = sp.getInt('contact__count');
    count ??= 0;

    sp.setString("contact__${count+1}__name", value['name']);
    sp.setString("contact__${count+1}__phone", value['phone']);
    sp.setString("contact__${count+1}__short", value['short']);
    sp.setInt("contact__${count+1}__pos", count+1);
    sp.setInt("contact__count", count+1);
    return true;
  }

  Future<List> getCables() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List cables = [];
    int? count = sp.getInt('cable__count');

    if (count != null && count > 0) {
      for (var i = 0; i < count; i++) {
        String? name = sp.getString("cable__${i+1}__name");
        String? id = sp.getString("cable__${i+1}__id");
        int? pos = sp.getInt("cable__${i+1}__pos");
        if (name != null && id != null) {
          cables.add({
            'name': name,
            'id': id,
            'pos': pos
          });
        }
      }
    }

    return cables;
  }

  Future<bool> logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  Future<bool> addCable(value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    int? count = sp.getInt('cable__count');
    count ??= 0;

    sp.setString("cable__${count+1}__name", value['name']);
    sp.setString("cable__${count+1}__id", value['id']);
    sp.setInt("cable__${count+1}__pos", count+1);
    sp.setInt("cable__count", count+1);

    return true;
  }

  Future<bool> removeCable(pos) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    sp.remove("cable__${pos}__name");
    sp.remove("cable__${pos}__id");
    sp.remove("cable__${pos}__pos");

    return true;
  }

  Future<bool> removeContact(pos) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    sp.remove("contact__${pos}__name");
    sp.remove("contact__${pos}__phone");
    sp.remove("contact__${pos}__short");

    return true;
  }
}