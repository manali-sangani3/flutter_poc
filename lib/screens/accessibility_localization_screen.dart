import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/l10n/app_localizations.dart';

import '../cubit/language_cubit.dart';

class AccessibilityLocalizationScreen extends StatelessWidget {
  const AccessibilityLocalizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.title)),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// ACCESSIBLE TITLE
              Semantics(
                header: true,

                label: AppLocalizations.of(context)!.title,

                child: Text(
                  AppLocalizations.of(context)!.title,

                  /// Dynamic Text Scaling Support
                  textScaler: MediaQuery.of(context).textScaler,

                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              const SizedBox(height: 12),

              /// Accessible Description
              Semantics(
                label: AppLocalizations.of(context)!.description,

                child: Text(
                  AppLocalizations.of(context)!.description,

                  textScaler: MediaQuery.of(context).textScaler,

                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              const SizedBox(height: 30),

              /// ACCESSIBILITY SETTINGS CARD
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      /// Language Toggle
                      Row(
                        children: [
                          const Icon(Icons.language),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.languageText,
                            ),
                          ),

                          Switch(
                            value:
                                context
                                    .watch<LanguageCubit>()
                                    .state
                                    .languageCode ==
                                'ar',

                            onChanged: (_) {
                              context.read<LanguageCubit>().toggleLanguage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                AppLocalizations.of(context)!.hello('User'),
                textScaler: MediaQuery.of(context).textScaler,

                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 30),

              /// ACCESSIBLE ACTION BUTTON
              Semantics(
                button: true,

                label: AppLocalizations.of(context)!.buttonText,

                hint: "Double tap to continue",

                child: Tooltip(
                  message: AppLocalizations.of(context)!.buttonText,

                  child: SizedBox(
                    width: double.infinity,

                    child: FilledButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.buttonText,
                            ),
                          ),
                        );
                      },

                      icon: const Icon(Icons.arrow_forward),

                      label: Text(AppLocalizations.of(context)!.buttonText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
