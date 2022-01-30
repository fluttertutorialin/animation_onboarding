class Page {
  const Page(
      this.title, this.subTitle, this.color, this.image, this.description);

  final String title, subTitle, image, description;
  final int color;
}

const pages = [
  Page('01.', 'Stylish Minimal Chair', 0xffF8E9D8, 'images/chair1.png',
      'Chair with minimal style and modern wooden and plastic material.'),
  Page('02.', 'Wooden Chair', 0xffA9C7C9, 'images/chair2.png',
      'Stylish chair with modern look and feel suitable for all ages.'),
  Page('03.', 'Green Egg Chair', 0xffA3C3B1, 'images/chair3.png',
      'Modern Egg chair with comfortable materials and a timeless design.'),
  Page('04.', 'Wooden Sofa', 0xffDEDFDF, 'images/chair4.png',
      'Wooden sofa with light weight materials available in different colors.'),
];
