// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../constants/strings.dart';
import '../constants/assets.dart';

class Skill {
  final String name;
  final double proficiency;
  final String icon;
  final Color color;
  final String description;

  const Skill({
    required this.name,
    required this.proficiency,
    required this.icon,
    required this.color,
    required this.description,
  });
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Skills',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 40,
              runSpacing: 32,
              children: skills
                  .map((skill) => SkillBadge(skill: skill, isMobile: isMobile))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillBadge extends StatefulWidget {
  final Skill skill;
  final bool isMobile;
  const SkillBadge({super.key, required this.skill, required this.isMobile});

  @override
  State<SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  bool isHovered = false;

  void _showDetailsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: widget.skill.color.withOpacity(0.15),
              child: Image.asset(
                widget.skill.icon,
                height: 30,
                width: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.skill.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.skill.description, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: widget.skill.proficiency,
              backgroundColor: widget.skill.color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(widget.skill.color),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text('${(widget.skill.proficiency * 100).toInt()}%',
                style: TextStyle(
                    color: widget.skill.color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badge = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: isHovered ? 90 : 80,
      height: isHovered ? 90 : 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.skill.color.withOpacity(0.15),
        boxShadow: isHovered
            ? [
                BoxShadow(
                    color: widget.skill.color.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ]
            : [
                const BoxShadow(
                    color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
              ],
        border: Border.all(color: widget.skill.color, width: 2),
      ),
      child: Center(
        child: Image.asset(
          widget.skill.icon,
          height: isHovered ? 44 : 36,
          width: isHovered ? 44 : 36,
        ),
      ),
    );

    final badgeWithTooltip = MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Stack(
        alignment: Alignment.center,
        children: [
          badge,
          if (isHovered)
            Positioned(
              top: 100,
              child: Material(
                color: Colors.transparent,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isHovered ? 1.0 : 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 12)
                      ],
                      border: Border.all(
                          color: widget.skill.color.withOpacity(0.2)),
                    ),
                    width: 220,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.skill.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.skill.color)),
                        const SizedBox(height: 6),
                        Text(widget.skill.description,
                            style: const TextStyle(fontSize: 13),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: widget.skill.proficiency,
                          backgroundColor: widget.skill.color.withOpacity(0.1),
                          valueColor:
                              AlwaysStoppedAnimation(widget.skill.color),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 4),
                        Text('${(widget.skill.proficiency * 100).toInt()}%',
                            style: TextStyle(
                                color: widget.skill.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.isMobile
            ? GestureDetector(
                onTap: () => _showDetailsModal(context),
                child: badge,
              )
            : badgeWithTooltip,
        const SizedBox(height: 12),
        Text(
          widget.skill.name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

final List<Skill> skills = [
  const Skill(
    name: AppStrings.skillFlutter,
    proficiency: 0.95,
    icon: AppAssets.flutterIcon,
    color: Color(0xFF02569B),
    description: AppStrings.skillFlutterDesc,
  ),
  const Skill(
    name: AppStrings.skillDart,
    proficiency: 0.90,
    icon: AppAssets.dartIcon,
    color: Color(0xFF00B4AB),
    description: AppStrings.skillDartDesc,
  ),
  const Skill(
    name: AppStrings.skillFirebase,
    proficiency: 0.85,
    icon: AppAssets.firebaseIcon,
    color: Color(0xFFFFCA28),
    description: AppStrings.skillFirebaseDesc,
  ),
   Skill(
    name: AppStrings.skillRestApis,
    proficiency: 0.90,
    icon: AppAssets.restApiIcon,
    color: Color.fromARGB(255, 187, 75, 43),
    description: AppStrings.skillRestApisDesc,
  ),
   Skill(
    name: AppStrings.skillGetX,
    proficiency: 0.85,
    icon: AppAssets.getXIcon,
    color: Color(0xFF7C4DFF),
    description: AppStrings.skillGetXDesc,
  ),
  const Skill(
    name: AppStrings.skillBloc,
    proficiency: 0.80,
    icon: AppAssets.blocIcon,
    color: Color(0xFF3F51B5),
    description: AppStrings.skillBlocDesc,
  ),
  const Skill(
    name: AppStrings.skillRiverpod,
    proficiency: 0.80,
    icon: AppAssets.riverpodIcon,
    color: Color(0xFF00BCD4),
    description: AppStrings.skillRiverpodDesc,
  ),
   Skill(
    name: AppStrings.skillUIUX,
    proficiency: 0.80,
    icon: AppAssets.uiUxIcon,
    color: Color(0xFFE91E63),
    description: AppStrings.skillUIUXDesc,
  ),
  const Skill(
    name: AppStrings.skillGit,
    proficiency: 0.85,
    icon: AppAssets.gitIcon,
    color: Color(0xFFF44336),
    description: AppStrings.skillGitDesc,
  ),
   Skill(
    name: AppStrings.skillSQLite,
    proficiency: 0.80,
    icon: AppAssets.sqliteIcon,
    color: Color(0xFF2196F3),
    description: AppStrings.skillSQLiteDesc,
  ),
  const Skill(
    name: AppStrings.skillTesting,
    proficiency: 0.75,
    icon: AppAssets.testingIcon,
    color: Color(0xFF795548),
    description: AppStrings.skillTestingDesc,
  ),
  const Skill(
    name: AppStrings.skillPushNotifications,
    proficiency: 0.85,
    icon: AppAssets.pushNotificationIcon,
    color: Color(0xFFFF9800),
    description: AppStrings.skillPushNotificationsDesc,
  ),
  const Skill(
    name: AppStrings.skillProjectManagement,
    proficiency: 0.85,
    icon: AppAssets.projectManagementIcon,
    color: Color(0xFF9C27B0),
    description: AppStrings.skillProjectManagementDesc,
  ),
];
