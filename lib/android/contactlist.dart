//
// import 'package:flutter/material.dart';
// import 'package:platform_converter/model/contact..dart';
// import 'package:platform_converter/provider/contect_provider.dart';
// import 'package:platform_converter/provider/main_parovider.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class Contactlist extends StatefulWidget {
//   const Contactlist({super.key});
//
//   @override
//   State<Contactlist> createState() => _ContactlistState();
// }
//
// class _ContactlistState extends State<Contactlist> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, "AddContact");
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: SafeArea(
//         child: Consumer<ContactProvider>(
//           builder: (BuildContext context, ContactProvider value, Widget? child) {
//             if (value.contactList.isEmpty) {
//               return const Center(
//                 child: Text(
//                   "No Contacts",
//                   style: TextStyle(fontSize: 50),
//                 ),
//               );
//             }
//             return Column(
//               children: [
//                 TextField(
//                     onChanged: (value) {
//                       Provider.of<MainProvider>(context, listen: false)
//                           .searchcontactByName(value);
//
//                     }),
//                 ListView.builder(
//                   itemCount: value.contactList.length,
//                   itemBuilder: (context, index) {
//                     Contact contact = value.contactList[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         shadowColor: Colors.pinkAccent,
//                         color: Colors.pink.shade50,
//                         elevation: 2,
//                         child: ListTile(
//                           onTap: () {
//                             launchUrl(Uri.parse("tel://${contact.number}"));
//                           },
//                           onLongPress: () {
//                             _showDeleteConfirmation(context, index);
//                           },
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.pinkAccent,
//                             child: Text(
//                               "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           title: Text(
//                             contact.name ?? "",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Text(
//                             contact.number ?? "",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, "AddContact", arguments: index);
//                                 },
//                                 icon: const Icon(Icons.edit, color: Colors.pinkAccent),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
//                                 },
//                                 child: const Icon(Icons.info_outline_rounded),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// void _showDeleteConfirmation(BuildContext context, int index) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Delete Contact"),
//         content: const Text("Are you sure you want to delete this contact?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Provider.of<ContactProvider>(context, listen: false).removeContact(index);
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Contact deleted")),
//               );
//             },
//             child: const Text("Delete"),
//           ),
//         ],
//       );
//     },
//   );
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/contact..dart';
import '../provider/contect_provider.dart';

class Contactlist extends StatefulWidget {
  const Contactlist({super.key});

  @override
  State<Contactlist> createState() => _ContactlistState();
}

class _ContactlistState extends State<Contactlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddContact");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SafeArea(
        child: Consumer<ContactProvider>(
          builder: (BuildContext context, ContactProvider value, Widget? child) {
            if (value.contactList.isEmpty) {
              return const Center(
                child: Text(
                  "No Contacts",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      Provider.of<ContactProvider>(context, listen: false)
                          .searchContactByName(query);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search by name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.contactList.length,
                    itemBuilder: (context, index) {
                      Contact contact = value.contactList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shadowColor: Colors.pinkAccent,
                          color: Colors.pink.shade50,
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              launchUrl(Uri.parse("tel://${contact.number}"));
                            },
                            onLongPress: () {
                              _showDeleteConfirmation(context, index);
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.pinkAccent,
                              child: Text(
                                "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              contact.name ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              contact.number ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "AddContact", arguments: index);
                                  },
                                  icon: const Icon(Icons.edit, color: Colors.pinkAccent),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                                  },
                                  child: const Icon(Icons.info_outline_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false).removeContact(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Contact deleted")),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
