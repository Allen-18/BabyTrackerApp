import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/homePage/list_of_my_kids.dart';

class GetScaffoldMyKids extends ConsumerWidget {
  const GetScaffoldMyKids({required this.myKids, super.key});
  final List<Kid> myKids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids'),
      ),
      body: SafeArea(child: ListOfMyKids(kids: myKids)),
    );
  }
}
