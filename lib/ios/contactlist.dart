
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/provider/contect_provider.dart';
import 'package:platform_converter/provider/main_parovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class IosContactlist extends StatefulWidget {
  const IosContactlist({super.key});

  @override
  State<IosContactlist> createState() => _IosContactlistState();
}

class _IosContactlistState extends State<IosContactlist> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Consumer<ContactProvider>(
          builder:
              (BuildContext context, ContactProvider value, Widget? child) {
            if (value.contactList.isEmpty) {
              return const Center(
                child: Text(
                  "No Contacts",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  CupertinoTextField(
                    onChanged: (value) {
                      Provider.of<MainProvider>(context, listen: false)
                          .searchcontactByName(value);

                  }),
                  ListView.builder(
                    itemCount: value.contactList.length,
                    itemBuilder: (context, index) {
                      Contact contact = value.contactList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse("tel://${contact.number}"));
                            },
                            onLongPress: () {
                              _showDeleteConfirmation(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.pinkAccent,
                                    child: Text(
                                      "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.name ?? "",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          contact.number ?? "",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(CupertinoIcons.pencil,
                                        color: Colors.black),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "AddContact",
                                          arguments: index);
                                    },
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(CupertinoIcons.info),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "DetailScreen",
                                          arguments: contact);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Floating Action Button
                  Positioned(
                    bottom: 5.0,
                    right: 5.0,
                    child: CupertinoButton(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      child:
                      const Icon(CupertinoIcons.add, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, "AddContact");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
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
              Provider.of<ContactProvider>(context, listen: false)
                  .removeContact(index);
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
