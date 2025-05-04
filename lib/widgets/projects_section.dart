import 'package:flutter/material.dart';
import 'package:flutter_portfolio/screens/all_projects_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
import '../constants/assets.dart';

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> technologies;
  final String link;
  final String? appleLink;
  final String? playstoreLink;
  final String? githublink;

  const Project(
      {required this.title,
      required this.description,
      required this.image,
      required this.technologies,
      required this.link,
      this.appleLink,
      this.githublink,
      this.playstoreLink});
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Projects',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black54
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                    ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllProjectsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              childAspectRatio: isMobile ? 1.2 : 1.5,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(
                project: projects[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Project Image
            Image.asset(
              widget.project.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
            // Project Title (Always visible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Text(
                  widget.project.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Project Details Overlay (Desktop only)
            if (!isMobile)
              MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isHovered
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
                        : Colors.transparent,
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.project.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.project.description,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              for (String tech in widget.project.technologies)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    tech,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.project.githublink != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                          onPressed: () async {
                                            final uri = Uri.parse(
                                                widget.project.githublink!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            }
                                          },
                                          icon: Image.network(
                                            AppAssets.githubIconUrl,
                                            height: 30,
                                            width: 30,
                                          )),
                                    )
                                  : const SizedBox.shrink(),
                              widget.project.playstoreLink != null
                                  ? const SizedBox(
                                      width: 20,
                                    )
                                  : const SizedBox.shrink(),
                              widget.project.appleLink != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                          onPressed: () async {
                                            final uri = Uri.parse(
                                                widget.project.appleLink!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            }
                                          },
                                          icon: Image.network(
                                            AppAssets.appStoreIconUrl,
                                            height: 30,
                                            width: 30,
                                          )),
                                    )
                                  : const SizedBox.shrink(),
                              widget.project.playstoreLink != null
                                  ? const SizedBox(
                                      width: 20,
                                    )
                                  : const SizedBox.shrink(),
                              widget.project.playstoreLink != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                          onPressed: () async {
                                            final uri = Uri.parse(
                                                widget.project.playstoreLink!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            }
                                          },
                                          icon: Image.network(
                                            AppAssets.playStoreIconUrl,
                                            height: 30,
                                            width: 30,
                                          )),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Project data
final List<Project> projects = [
  const Project(
    githublink: "https://github.com/abdul-salam111/Horumarkaal-App",
    playstoreLink:
        "https://play.google.com/store/apps/details?id=com.horumarkaalapp.multitranslation&pcampaignid=web_share",
    title: AppStrings.projectHorumarkaal,
    description: AppStrings.projectHorumarkaalDesc,
    image: AppAssets.horumarkaalImage,
    technologies: [
      'Flutter',
      'APIs',
      'Getx',
      'Pusher',
      'Chat',
      'MVC',
      'Git',
      'Stripe',
      'Github'
    ],
    link: AppAssets.horumarkaalLink,
  ),
  const Project(
    title: AppStrings.projectGBC,
    githublink: "https://github.com/abdul-salam111/Guided-By-Culture",
    description: AppStrings.projectGBCDesc,
    image: AppAssets.gbcImage,
    technologies: [
      'Flutter',
      'Firebase',
      'Stripe',
      'APIs',
      'Getx',
      'MVC',
      'Git',
      'Github',
      'Sqlite'
    ],
    link: AppAssets.gbcLink,
  ),
  const Project(
    githublink: "https://github.com/abdul-salam111/Auction-App",
    title: AppStrings.projectBigStar,
    description: AppStrings.projectBigStarDesc,
    image: AppAssets.bigStarImage,
    technologies: ['Flutter', 'APIs', 'Getx', 'MVC', 'Git', 'Github', "Sqlite"],
    link: AppAssets.bigStarLink,
  ),
  const Project(
    githublink:
        "https://github.com/abdul-salam111/patient-mgt-system/tree/main",
    title: AppStrings.projectPMS,
    description: AppStrings.projectPMSDesc,
    image: AppAssets.pmsImage,
    technologies: [
      'Flutter',
      'APIs',
      'Getx',
      'Pusher',
      'Chat',
      'MVC',
      'Git',
      'Github'
    ],
    link: AppAssets.pmsLink,
  ),
  const Project(
    githublink: "https://github.com/abdul-salam111/RAH-Tourism",
    title: AppStrings.projectRAHTourism,
    description: AppStrings.projectRAHTourismDesc,
    image: AppAssets.rahTourismImage,
    technologies: [
      'Flutter',
      'Firebase',
      'APIs',
      'Getx',
      'Chat',
      'MVC',
      'Git',
      'Stripe',
      'Github'
    ],
    link: AppAssets.rahTourismLink,
  ),
  const Project(
    githublink: "https://github.com/abdul-salam111/FruitFly-App",
    title: AppStrings.projectFruitFly,
    description: AppStrings.projectFruitFlyDesc,
    image: AppAssets.fruitFlyImage,
    technologies: [
      'Flutter',
      'APIs',
      'Getx',
      'Chat',
      'MVC',
      'Git',
      'Stripe',
      'Github'
    ],
    link: AppAssets.fruitFlyLink,
  ),
];
