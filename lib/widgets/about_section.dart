import 'package:flutter/material.dart';
import 'package:flutter_portfolio/config/theme/app_theme.dart';
import 'package:flutter_portfolio/constants/assets.dart';
import 'package:flutter_portfolio/constants/strings.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isMobile)
                    const SizedBox(
                      height: 60,
                    ),
                  Text(
                    AppStrings.profileGreeting,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: isMobile ? 20 : 30,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.profileName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 50 : 60,
                        ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        AppStrings.profileTitle,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: isLight ? Colors.black87 : Colors.white,
                              fontSize: isMobile ? 14 : 30,
                            ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.aboutMeDesc,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(179),
                          height: 1.6,
                          fontSize: isMobile ? 14 : 16,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    AppStrings.followMe,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 16 : 20,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialButton(
                        context,
                        icon: AppAssets.githubIconUrl,
                        label: AppStrings.github,
                        url: AppStrings.githubUrl,
                      ),
                      const SizedBox(width: 16),
                      _buildSocialButton(
                        context,
                        icon: AppAssets.linkedinIconUrl,
                        label: AppStrings.linkedin,
                        url: AppStrings.linkedinUrl,
                      ),
                      const SizedBox(width: 16),
                      _buildSocialButton(
                        context,
                        icon: AppAssets.facebookIconUrl,
                        label: AppStrings.facebook,
                        url: AppStrings.facebookUrl,
                      ),
                      const SizedBox(width: 16),
                      _buildSocialButton(
                        context,
                        icon: AppStrings.instagramurl,
                        label: AppStrings.insta,
                        url: AppAssets.instagramprofileurl,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 48),
            Expanded(flex: 1, child: Image.asset(AppAssets.abdulpic)),
          ],
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required String icon,
    required String label,
    required String url,
  }) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(50)),
      child: IconButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        icon: Image.network(
          icon,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
