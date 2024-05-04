import 'package:flutter/material.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/helpers/colors_manager.dart';

class ListOfMyKids extends StatelessWidget {
  const ListOfMyKids({required this.kids, super.key});

  final List<Kid> kids;

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
            padding: const EdgeInsets.all(8),
            itemCount: kids.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: AppColors.primary,
                child: ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(
                    child: Text(''),
                  ),
                  title: Text(
                    kids[index].name,
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '${kids[index].gender} ${kids[index].getCurrentAge(kids[index].dateOfBirth)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
