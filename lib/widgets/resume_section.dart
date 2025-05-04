import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;


    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resume',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
                  children: [
                    _buildExperienceSection(context),
                    const SizedBox(height: 48),
                    _buildEducationSection(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildExperienceSection(context),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: _buildEducationSection(context),
                    ),
                  ],
                ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Download Resume',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 32),
        _buildTimelineItem(
          context,
          title: 'Senior Flutter Developer',
          company: 'Saeedan Technology',
          period: '2023 - Present',
          description:
              'Leading mobile app development team, implementing complex features and mentoring junior developers.',
        ),
        const SizedBox(height: 24),
        _buildTimelineItem(
          context,
          title: 'Flutter Developer',
          company: 'Codematics',
          period: '2022 - 2023',
          description:
              'Developed and maintained multiple Flutter applications, focusing on performance optimization and user experience.',
        ),
      ],
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 32),
        _buildTimelineItem(
          context,
          title: 'Bachelor of Software Engineering',
          company: 'Abbottabad University of Science and Technology',
          period: '2013 - 2017',
          description:
              "During my Bachelor's degree, I built a strong foundation in core programming concepts, data structures, and algorithms.",
        ),
        const SizedBox(height: 24),
        _buildTimelineItem(context,
            title: 'A Level in ICS',
            company: 'Doaba Higher Secondary School and College',
            period: '2017 - 2019',
            description:
                'Studied Intermediate in Computer Science with a focus on the fundamentals of programming, and computer systems,logic building,and problem-solving'),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String company,
    required String period,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            company,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              period,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
