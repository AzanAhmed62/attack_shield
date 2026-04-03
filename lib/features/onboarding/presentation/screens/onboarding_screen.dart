import 'package:flutter/material.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to ATT&CK Defender')),
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        children: [
          // Page 1 - Welcome
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to ATT&CK Defender',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'A defensive cybersecurity app powered by MITRE ATT&CK',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // Page 2 - What is ATT&CK
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: 80, color: Theme.of(context).primaryColor),
              const SizedBox(height: 24),
              Text(
                'What is MITRE ATT&CK?',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'A globally accessible knowledge base of adversary tactics and techniques based on real-world observations.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // Page 3 - Select Use Case
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What will you use this for?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.school),
                      label: const Text('Personal Learning'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.engineering),
                      label: const Text('Lab Environment'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.business),
                      label: const Text('Organization'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentPage > 0)
              TextButton(
                onPressed: () {
                  // Navigate to previous page
                },
                child: const Text('Back'),
              )
            else
              const SizedBox(width: 80),
            Text('${currentPage + 1}/3'),
            if (currentPage < 2)
              TextButton(
                onPressed: () {
                  // Navigate to next page
                },
                child: const Text('Next'),
              )
            else
              TextButton(
                onPressed: () {
                  // Complete onboarding
                },
                child: const Text('Start'),
              ),
          ],
        ),
      ),
    );
  }
}
