import 'package:chatappsuas/pages/chat_page.dart';
import 'package:chatappsuas/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatappsuas/pages/add_contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  Future<String> getContactEmail(String contactID) async {
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(contactID)
          .get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('email')) {
        return data['email'] as String;
      } else {
        print('Contact email not found.');
        return '';
      }
    } catch (e) {
      print('Error retreiving contact email: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home Page',
            style: TextStyle(color: Color(0xFF041C32)),
          ),
        ),
        backgroundColor: Color(0xFFECB365),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            color: Color(0xFF041C32),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContact()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFECB365),
      ),
    );
  }

  Widget _buildUserList() {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return const Text('User not authenticated');
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error fetching user data');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        List<String> contactUserIds = [];
        if (snapshot.data!.exists && snapshot.data!['contacts'] != null) {
          contactUserIds = List<String>.from(snapshot.data!['contacts']);
        }

        return ListView.builder(
          itemCount: contactUserIds.length,
          itemBuilder: (context, index) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(contactUserIds[index])
                  .get(),
              builder: (context, contactSnapshot) {
                if (contactSnapshot.hasError) {
                  return const Text('Error fetching contact data');
                }

                if (contactSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text('Loading contact...');
                }
                Map<String, dynamic> contactData =
                    contactSnapshot.data!.data() as Map<String, dynamic>;
                String contactEmail = contactData['email'];

                return ListTile(
                  title: Text(
                    contactEmail,
                    style: TextStyle(color: Color(0xFFECB365)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserEmail: contactEmail,
                          receiverUserID: contactUserIds[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
