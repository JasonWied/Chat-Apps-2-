import 'package:chatappsuas/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatappsuas/components/button.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final contactController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void addContact(String contactEmail) async {
    User? user = _firebaseAuth.currentUser;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: contactEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String contactID = documentSnapshot.id;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({
          'contacts': FieldValue.arrayUnion([contactID])
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(contactID)
            .update({
          'contacts': FieldValue.arrayUnion([user?.uid])
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact added successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact not found.'),
          ),
        );
      }
    } catch (e) {
      print('Error adding contact: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while adding the contact.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041C32),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              const SizedBox(height: 30),
              MyTextField(
                  controller: contactController,
                  hintText: 'Enter friend"s email',
                  obscureText: false),
              MyButton(
                  onTap: () {
                    addContact(contactController.text);
                  },
                  text: "Add Contact"),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
