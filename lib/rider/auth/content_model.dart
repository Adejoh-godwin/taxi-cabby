class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Request Ride',
      image: 'assets/onboarding/onb1.png',
      description:
          "Enter destination location to request a ride from available drivers nearby"),
  OnboardingContent(
      title: 'Confirm Your Driver',
      image: 'assets/onboarding/onb2.png',
      description:
          "Track your Order as a customer or track order as dispatch rider"),
  OnboardingContent(
      title: 'Track Your Ride ',
      image: 'assets/onboarding/onb3.png',
      description: "Register, List and Reach new customers, get more sales "),
];
