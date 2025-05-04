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

  const Project({
    required this.title,
    required this.description,
    required this.image,
    required this.technologies,
    required this.link,
    this.appleLink,
    this.githublink,
    this.playstoreLink,
  });
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
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
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllProjectsScreen(),
                  ),
                ),
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
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
            itemBuilder: (context, index) => ProjectCard(project: projects[index]),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

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
            _buildProjectImage(),
            _buildProjectTitle(),
            if (!isMobile) _buildProjectDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Image.asset(
      widget.project.image,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectTitle() {
    return Positioned(
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
    );
  }

  Widget _buildProjectDetails() {
    return MouseRegion(
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
                _buildTechnologies(),
                const SizedBox(height: 10),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechnologies() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: widget.project.technologies
          .map((tech) => Container(
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
              ))
          .toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.project.githublink != null)
          _buildActionButton(
            AppAssets.githubIconUrl,
            widget.project.githublink!,
          ),
        if (widget.project.appleLink != null)
          _buildActionButton(
            AppAssets.appStoreIconUrl,
            widget.project.appleLink!,
          ),
        if (widget.project.playstoreLink != null)
          _buildActionButton(
            AppAssets.playStoreIconUrl,
            widget.project.playstoreLink!,
          ),
      ],
    );
  }

  Widget _buildActionButton(String iconUrl, String link) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () => _launchUrl(link),
        icon: Image.network(
          iconUrl,
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

final List<Project> projects = [
  Project(
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
  Project(
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
  Project(
    githublink: "https://github.com/abdul-salam111/Auction-App",
    title: AppStrings.projectBigStar,
    description: AppStrings.projectBigStarDesc,
    image: AppAssets.bigStarImage,
    technologies: ['Flutter', 'APIs', 'Getx', 'MVC', 'Git', 'Github', "Sqlite"],
    link: AppAssets.bigStarLink,
  ),
  Project(
    githublink: "https://github.com/abdul-salam111/patient-mgt-system/tree/main",
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
  Project(
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
  Project(
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
