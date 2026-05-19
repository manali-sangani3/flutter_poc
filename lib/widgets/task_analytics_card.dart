import 'package:flutter/material.dart';

import 'package:flutter_poc/isolates/analytics_isolate.dart';
import 'package:flutter_poc/theme/app_colors.dart';

import 'analytics_tile.dart';

/// Reusable Analytics Widget
class TaskAnalyticsCard extends StatelessWidget {
  final AnalyticsResult analytics;

  const TaskAnalyticsCard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// Title
          const Text(
            "Task Analytics",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          /// Responsive Completed & Pending Layout
          LayoutBuilder(

            builder: (context, constraints) {

              /// Detect large screen
              final isLargeScreen =
                  constraints.maxWidth > 600;

              return isLargeScreen

              /// WEB / TABLET UI
                  ? Row(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Expanded(
                    child: analyticsTile(
                      "Completed",
                      analytics.completed.toString(),
                      AppColors.green,
                      context
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: analyticsTile(
                      "Pending",
                      analytics.pending.toString(),
                      AppColors.orange,
                        context
                    ),
                  ),
                ],
              )

              /// MOBILE UI
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  analyticsTile(
                    "Completed",
                    analytics.completed.toString(),
                    AppColors.green,
                      context
                  ),

                  const SizedBox(height: 14),

                  analyticsTile(
                    "Pending",
                    analytics.pending.toString(),
                    AppColors.orange,
                      context
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          /// Productivity Text
          Text(
            "Productivity : "
                "${analytics.productivity.toStringAsFixed(1)}%",

            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          /// Animated Productivity Bar
          TweenAnimationBuilder(

            tween: Tween<double>(
              begin: 0,
              end: analytics.productivity / 100,
            ),

            duration: const Duration(seconds: 1),

            builder: (_, value, __) {

              return LinearProgressIndicator(
                value: value,
                minHeight: 10,

                borderRadius:
                BorderRadius.circular(20),
              );
            },
          ),
        ],
      )
    );
  }
}
