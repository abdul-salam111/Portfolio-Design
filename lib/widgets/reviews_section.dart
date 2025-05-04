// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:async';

class Review {
  final String name;
  final String position;
  final String company;
  final String review;
  final String image;
  final double rating;

  const Review({
    required this.name,
    required this.position,
    required this.company,
    required this.review,
    required this.image,
    required this.rating,
  });
}

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      final isMobile = ResponsiveBreakpoints.of(context).isMobile;
      final totalPages = (reviews.length / (isMobile ? 1 : 2)).ceil() - 1;

      if (_currentPage < totalPages) {
        _currentPage++;
        _scrollToPage(_currentPage);
      } else {
        // Reset to the first page with animation
        _currentPage = 0;
        _scrollToPage(_currentPage);
      }
    });
  }

  void _scrollToPage(int page) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final padding = isMobile ? 32 : 48;
    final itemWidth = screenWidth - padding;

    _scrollController.animateTo(
      page * itemWidth,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final totalPages = (reviews.length / (isMobile ? 1 : 2)).ceil() - 1;

    if (_currentPage < totalPages) {
      _currentPage++;
      _scrollToPage(_currentPage);
    } else {
      _currentPage = 0;
      _scrollToPage(_currentPage);
    }
  }

  void _previousPage() {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final totalPages = (reviews.length / (isMobile ? 1 : 2)).ceil() - 1;

    if (_currentPage > 0) {
      _currentPage--;
      _scrollToPage(_currentPage);
    } else {
      _currentPage = totalPages;
      _scrollToPage(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Reviews',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 28 : null,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'What people say about my work',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                  fontSize: isMobile ? 16 : null,
                ),
          ),
          const SizedBox(height: 48),
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (reviews.length / (isMobile ? 1 : 2)).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * (isMobile ? 1 : 2);
                    final endIndex =
                        (startIndex + (isMobile ? 1 : 2)) > reviews.length
                            ? reviews.length
                            : startIndex + (isMobile ? 1 : 2);
                    final currentReviews =
                        reviews.sublist(startIndex, endIndex);

                    return Container(
                      width: MediaQuery.of(context).size.width -
                          (isMobile ? 32 : 48),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: currentReviews
                            .map((review) => Expanded(
                                  child: _buildReviewCard(
                                      context, review, isMobile),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: isMobile ? 15 : 15,
                      ),
                      onPressed: _previousPage,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: isMobile ? 15 : 15,
                      ),
                      onPressed: _nextPage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isMobile ? 50 : 60,
                height: isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(review.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 18 : null,
                          ),
                    ),
                    Text(
                      '${review.position} at ${review.company}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                            fontSize: isMobile ? 14 : null,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < review.rating.floor()
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                size: isMobile ? 16 : 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            review.review,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  height: 1.6,
                  fontSize: isMobile ? 14 : null,
                ),
          ),
        ],
      ),
    );
  }
}

// Sample reviews data
final List<Review> reviews = [
  const Review(
    name: 'John Smith',
    position: 'Product Manager',
    company: 'TechCorp',
    review:
        'Abdul is an exceptional Flutter developer. His attention to detail and problem-solving skills are outstanding. He delivered our project on time and exceeded our expectations.',
    image:
        "https://t3.ftcdn.net/jpg/08/85/71/00/360_F_885710027_hYfWACJQNFn5uszCQM4BDgvCZJlsJ3vB.jpg",
    rating: 5.0,
  ),
  const Review(
    name: 'Sarah Johnson',
    position: 'CTO',
    company: 'StartUpX',
    review:
        'Working with Abdul was a great experience. His technical expertise and communication skills made the development process smooth and efficient. Highly recommended!',
    image:
        'https://media.licdn.com/dms/image/v2/D4E03AQERHxdW9JVbKQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1691516210400?e=2147483647&v=beta&t=n_ttdBTWPG2yeE8yYE_W2RvPmCjUIN6o-gZs4Zn96Lk',
    rating: 5.0,
  ),
  const Review(
    name: 'Michael Brown',
    position: 'CEO',
    company: 'InnovateTech',
    review:
        'Abdul\'s work on our mobile app was exceptional. He not only delivered high-quality code but also provided valuable insights that improved our product significantly.',
    image:
        'https://media.licdn.com/dms/image/v2/D4E03AQHliby9oBunLw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1709983236263?e=2147483647&v=beta&t=hBLpfuTJK5uZO6nBMZQf2o5zns3x1VSASPFbe1QkcNI',
    rating: 5.0,
  ),
  const Review(
    name: 'Emily Carter',
    position: 'Marketing Director',
    company: 'BrightWave Media',
    review:
        'Working with Abdul was a game-changer. His attention to detail and creative solutions helped us launch our campaign ahead of schedule.',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfoGoCBeepyXgyhJNk2fQKvXInLIpbvEHkWw&s',
    rating: 5.0,
  ),
];
