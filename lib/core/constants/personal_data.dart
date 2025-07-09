import '../entities/personal_info.dart';

class PersonalData {
  static const PersonalInfo info = PersonalInfo(
    name: 'Israel Oliveira',
    title: 'Desenvolvedor Flutter & Mobile',
    description:
        'Desenvolvedor de aplicativos móveis, web e desktop '
        'usando Flutter. \nInclusive, está página foi desenvolvida utilizando Flutter.',
    email: 'israeloliveira.dev@gmail.com',
    phone: '+55 (14) 99687-6751',
    location: 'São Paulo, Brasil',
    profileImageUrl: 'https://avatars.githubusercontent.com/u/104089819?v=4',
    socialLinks: [
      SocialLink(
        name: 'GitHub',
        url: 'https://github.com/israel-oliveira',
        iconName: 'github',
      ),
      SocialLink(
        name: 'LinkedIn',
        url: 'https://linkedin.com/in/israel-oliveira-dev',
        iconName: 'linkedin',
      ),
      SocialLink(
        name: 'Twitter',
        url: 'https://twitter.com/fdev_israel',
        iconName: 'twitter',
      ),
      SocialLink(
        name: 'Instagram',
        url: 'https://instagram.com/fdev_israel',
        iconName: 'instagram',
      ),
    ],
  );
}
