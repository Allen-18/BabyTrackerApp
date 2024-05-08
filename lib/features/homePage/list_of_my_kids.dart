import 'package:flutter/material.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/mainScreen/categories_page.dart';

class ListOfMyKids extends StatelessWidget {
  const ListOfMyKids(
      {required this.kids, super.key, required this.currentUser});

  final List<Kid> kids;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return kids.isEmpty
        ? const Center(
            child: Text(
              'Nu sunt inregistrati copiii',
              style: TextStyle(fontSize: 30),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: kids.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(8),
                color: AppColors.primary,
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Text(''),
                  ),
                  title: Text(
                    kids[index].name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            'are ${kids[index].getCurrentAge(kids[index].dateOfBirth)}',
                            style: const TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Categories(
                                  kid: kids[index],
                                  currentUser: currentUser,
                                )),
                      );
                    }, // Arrow icon
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(''),
                  ),
                ),
              );
            },
          );
  }
}
