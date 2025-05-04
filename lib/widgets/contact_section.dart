// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;


    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile
            ? 16
            : isTablet
                ? 32
                : 48,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Get In Touch',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light 
                      ? Colors.black87 
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile
                      ? 32
                      : isTablet
                          ? 40
                          : 48,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Feel free to reach out to me for any opportunities or just to say hello!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light 
                      ? Colors.black54 
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: isMobile ? 14 : 16,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: _buildContactCards(context, isMobile: true),
            )
          else if (isTablet)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: _buildContactCards(context, isMobile: false),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildContactCards(context, isMobile: false),
            ),
          const SizedBox(height: 48),
          Text(
            'Or send me an email directly',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light 
                      ? Colors.black54 
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: isMobile ? 14 : 16,
                ),
          ),
          const SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchUrl('mailto:abdulsalam.0302@gmail.com'),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 8 : 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png",
                      height: isMobile ? 20 : 24,
                      width: isMobile ? 20 : 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'abdulsalam.0302@gmail.com',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 14 : 16,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContactCards(BuildContext context,
      {required bool isMobile}) {
    final cardSize = isMobile ? 160.0 : 200.0;
    final iconSize = isMobile ? 24.0 : 32.0;
    final titleSize = isMobile ? 16.0 : 20.0;
    final subtitleSize = isMobile ? 12.0 : 14.0;

    return [
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _ContactCard(
          icon:
              "https://cdn1.iconfinder.com/data/icons/logotypes/32/circle-linkedin-512.png",
          title: 'LinkedIn',
          subtitle: 'Connect with me',
          onTap: () => _launchUrl('https://www.linkedin.com/in/abdulsalamas/'),
          color: const Color(0xFF0077B5),
          size: cardSize,
          iconSize: iconSize,
          titleSize: titleSize,
          subtitleSize: subtitleSize,
        ),
      ),
      SizedBox(width: isMobile ? 16 : 24, height: isMobile ? 16 : 24),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _ContactCard(
          icon:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Octicons-mark-github.svg/2048px-Octicons-mark-github.svg.png",
          title: 'GitHub',
          subtitle: 'Check my work',
          onTap: () => _launchUrl('https://github.com/abdul-salam111'),
          color: const Color(0xFF333333),
          size: cardSize,
          iconSize: iconSize,
          titleSize: titleSize,
          subtitleSize: subtitleSize,
        ),
      ),
      SizedBox(width: isMobile ? 16 : 24, height: isMobile ? 16 : 24),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _ContactCard(
          icon: "https://cdn-icons-png.freepik.com/256/17025/17025066.png",
          title: 'Phone',
          subtitle: '+923115308116',
          onTap: () => _launchUrl('tel:+923115308116'),
          color: Theme.of(context).colorScheme.primary,
          size: cardSize,
          iconSize: iconSize,
          titleSize: titleSize,
          subtitleSize: subtitleSize,
        ),
      ),
    ];
  }
}

class _ContactCard extends StatefulWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final double size;
  final double iconSize;
  final double titleSize;
  final double subtitleSize;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    required this.size,
    required this.iconSize,
    required this.titleSize,
    required this.subtitleSize,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(isHovered ? 0.2 : 0.1),
                blurRadius: isHovered ? 16 : 8,
                offset: Offset(0, isHovered ? 8 : 4),
              ),
            ],
            border: Border.all(
              color: widget.color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(widget.iconSize / 2),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  widget.icon,
                  height: widget.iconSize,
                  width: widget.iconSize,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light 
                          ? Colors.black87 
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.titleSize,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: widget.subtitleSize, 
                    color: Theme.of(context).brightness == Brightness.light 
                        ? Colors.black54 
                        : Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
