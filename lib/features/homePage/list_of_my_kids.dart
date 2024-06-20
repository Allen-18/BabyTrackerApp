import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/drawer/kid_avatar.dart';
import 'package:tracker/features/children/kids_repository.dart';

import '../drawer/parent_avatar.dart' as parent;
import '../drawer/parent_avatar.dart';

class ListOfMyKids extends ConsumerWidget {
  const ListOfMyKids(
      {required this.kids, super.key, required this.currentUser});

  final List<Kid> kids;
  final User currentUser;

  bool areAllSkillsEmpty(Kid kid) {
    return (kid.motorSkills.isEmpty) &&
        (kid.cognitiveSkills.isEmpty) &&
        (kid.socialSkills.isEmpty) &&
        (kid.linguisticSkills.isEmpty);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle monitoringTextStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF4788C7),
    );

    return Scaffold(
      body: kids.isEmpty
          ? const Center(
              child: Text(
                'Nu sunt înregistrați copiii',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemCount: kids.length,
              itemBuilder: (BuildContext context, int index) {
                Kid kid = kids[index];
                final kidFuture =
                    ref.watch(getKidFutureProvider(kidId: kid.id!));

                return kidFuture.when(
                  data: (updatedKid) {
                    // Motor skills message
                    String motorSkillsMessage;
                    String newestMotorSkillTimestamp =
                        getNewestMotorSkillTimestamp(
                            updatedKid?.motorSkills.toList() ?? []);
                    if (newestMotorSkillTimestamp ==
                        'Nu sunt înregistrate abilități motorii') {
                      motorSkillsMessage = newestMotorSkillTimestamp;
                    } else {
                      motorSkillsMessage =
                          'Abilități motorii actualizate în urmă cu ${timeAgo(newestMotorSkillTimestamp)}';
                    }

                    // Cognitive skills message
                    String cognitiveSkillsMessage;
                    String newestCognitiveSkillTimestamp =
                        getNewestCognitiveSkillTimestamp(
                            updatedKid?.cognitiveSkills.toList() ?? []);
                    if (newestCognitiveSkillTimestamp ==
                        'Nu sunt înregistrate abilități cognitive') {
                      cognitiveSkillsMessage = newestCognitiveSkillTimestamp;
                    } else {
                      cognitiveSkillsMessage =
                          'Abilități cognitive actualizate în urmă cu ${timeAgo(newestCognitiveSkillTimestamp)}';
                    }

                    // Social skills message
                    String socialSkillsMessage;
                    String newestSocialSkillTimestamp =
                        getNewestSocialSkillTimestamp(
                            updatedKid?.socialSkills.toList() ?? []);
                    if (newestSocialSkillTimestamp ==
                        'Nu sunt înregistrate abilități sociale') {
                      socialSkillsMessage = newestSocialSkillTimestamp;
                    } else {
                      socialSkillsMessage =
                          'Abilități sociale actualizate în urmă cu ${timeAgo(newestSocialSkillTimestamp)}';
                    }

                    // Linguistic skills message
                    String linguisticSkillsMessage;
                    String newestLinguisticSkillTimestamp =
                        getNewestLinguisticSkillTimestamp(
                            updatedKid?.linguisticSkills.toList() ?? []);
                    if (newestLinguisticSkillTimestamp ==
                        'Nu sunt înregistrate abilități lingvistice') {
                      linguisticSkillsMessage = newestLinguisticSkillTimestamp;
                    } else {
                      linguisticSkillsMessage =
                          'Abilități lingvistice actualizate în urmă cu ${timeAgo(newestLinguisticSkillTimestamp)}';
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    KidNetworkAvatar(
                                      kid: updatedKid!,
                                      avatarSize: AvatarSize.drawerBig,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: parent.ParentNetworkAvatar(
                                        parent: currentUser,
                                        avatarSize:
                                            AvatarSizeForParent.listTile,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        updatedKid.name,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'are ${updatedKid.getCurrentAge(updatedKid.dateOfBirth)}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/physical.png',
                                  width: 44,
                                  height: 44,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Ultimele monitorizări motorii',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4788C7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              motorSkillsMessage,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/cognitive.png',
                                  width: 44,
                                  height: 44,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Ultimele monitorizări cognitive',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4788C7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              cognitiveSkillsMessage,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/social.png',
                                  width: 44,
                                  height: 44,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Ultimele monitorizări sociale',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4788C7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              socialSkillsMessage,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/language.png',
                                  width: 44,
                                  height: 44,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Ultimele monitorizări lingvistice',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4788C7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              linguisticSkillsMessage,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton.icon(
                                onPressed: () {
                                  context.pushNamed(AppRoutes.category.name,
                                      extra: {
                                        'user': currentUser,
                                        'kid': updatedKid,
                                      });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF4788C7),
                                ),
                                label: areAllSkillsEmpty(updatedKid)
                                    ? Text(
                                        'Începeți monitorizarea',
                                        style: monitoringTextStyle,
                                      )
                                    : Text(
                                        'Continuați monitorizarea',
                                        style: monitoringTextStyle,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      const Center(child: Text('Error loading kid data')),
                );
              },
            ),
    );
  }
}
