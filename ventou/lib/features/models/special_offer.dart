class SpecialOffer {
  final String discount;
  final String title;
  final String detail;
  final String icon;

  SpecialOffer({
    required this.discount,
    required this.title,
    required this.detail,
    required this.icon,
  });
}

final homeSpecialOffers = <SpecialOffer>[
  SpecialOffer(
    discount: '25%',
    title: "Today’s Special!",
    detail: 'Get discount for every order, only valid for today',
    icon: 'assets/shapof.webp',
  ),
  SpecialOffer(
    discount: '35%',
    title: "Tomorrow will be better!",
    detail: 'Please give me a star!',
    icon: 'assets/sac.webp',
  ),
  SpecialOffer(
    discount: '100%',
    title: "Not discount today!",
    detail: 'If you have any problem, contact me',
    icon: 'assets/sac3.webp',
  ),
  SpecialOffer(
    discount: '75%',
    title: "It's for you!",
    detail: 'Wish you have a funny time',
    icon: 'assets/sac2.webp',
  ),
  SpecialOffer(
    discount: '65%',
    title: "Make yourself at home!",
    detail: 'If you have any confuse, let me now',
    icon: 'assets/sandalef.jpg',
  ),
];
