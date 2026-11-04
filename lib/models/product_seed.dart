import 'product.dart';

List<Product> buildSeedProducts() => [
      Product(
        id: '1',
        title: 'Tom Ford Oud Wood',
        category: 'Eau de Parfum',
        price: '\$395.00',
        rating: '4.9',
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=c7b5cf0ddc1f157ce72ac741d3f21f108165e844-5285663-images-thumbs&n=13',
        description:
            'A rare, exotic, and distinctive fragrance featuring classic woods and the iconic Tom Ford oud. Features rich notes of rose wood and cardamom.',
      ),
      Product(
        id: '2',
        title: 'Baccarat Rouge 540',
        category: 'Extrait de Parfum',
        price: '\$425.00',
        rating: '4.8',
        imageUrl:
            'https://cdn.4stand.com/large2x/fd/b5/fdb5ab9323f3370bd4187b79d4ffaa8c367ea53e.webp',
        description:
            'Luminous and sophisticated, Baccarat Rouge 540 lays on the skin like an amber floral and woody breeze.',
      ),
      Product(
        id: '3',
        title: 'Creed Aventus',
        category: 'Eau de Parfum',
        price: '\$365.00',
        rating: '4.7',
        imageUrl:
            'https://basket-38.wbbasket.ru/vol8729/part872950/872950634/images/big/1.webp',
        description:
            'Sensual, audacious and contemporary, this rich and iconic Eau de Parfum combines tantalizing fruity head notes with a woody base.',
      ),
      Product(
        id: '4',
        title: 'Chanel Coco Mademoiselle',
        category: 'Eau de Parfum',
        price: '\$150.00',
        rating: '4.6',
        imageUrl: 'https://avatars.mds.yandex.net/get-mpic/16217302/img_id6250155849147503854.jpeg/orig',
        description:
            'An oriental, fresh and sensual fragrance with notes of orange, jasmine, rose and patchouli.',
      ),
      Product(
        id: '5',
        title: 'YSL Black Opium',
        category: 'Eau de Parfum',
        price: '\$135.00',
        rating: '4.5',
        imageUrl: 'https://avatars.mds.yandex.net/i?id=f14d18e3aaea50bb62ee0475b53ca60834409c83-5617347-images-thumbs&n=13',
        description:
            'An addictive gourmand floral with black coffee, white flowers and a sweet vanilla trail.',
      ),
      Product(
        id: '6',
        title: "Hermès Terre d'Hermès",
        category: 'Eau de Toilette',
        price: '\$120.00',
        rating: '4.6',
        imageUrl: 'https://avatars.mds.yandex.net/i?id=62a044c79da10b3bbe9d752e40b39a74_l-3530254-images-thumbs&n=13',
        description:
            'A mineral woody fragrance built around orange, flint and vetiver. Earthy, bold and timeless.',
      ),
      Product(
        id: '7',
        title: 'MFK Grand Soir',
        category: 'Eau de Parfum',
        price: '\$310.00',
        rating: '4.7',
        imageUrl: 'https://allureparfum.ru/upload/iblock/05d/05d2cc6008405f130c7548560c951d99.jpg',
        description:
            'A warm amber evening fragrance with benzoin, labdanum and tonka bean.',
      ),
      Product(
        id: '8',
        title: 'Guerlain Shalimar',
        category: 'Parfum',
        price: '\$180.00',
        rating: '4.4',
        imageUrl: 'https://avatars.mds.yandex.net/get-mpic/20419546/2a0000019e3a7f208fb0ac4b5d4e97c5646c/orig',
        description:
            'The legendary oriental: bergamot, iris, vanilla and a smoky, sensual dry-down.',
      ),
      Product(
        id: '9',
        title: "Dior J'adore",
        category: 'Eau de Parfum',
        price: '\$145.00',
        rating: '4.5',
        imageUrl: 'https://cdn.spellsmell.ru/rc/98b0c735-eb4d-4498-853d-9202c2f6dd5d.jpg',
        description:
            'A luminous floral bouquet of ylang-ylang, damascus rose and jasmine.',
      ),
      Product(
        id: '10',
        title: 'Armani Acqua di Giò Profumo',
        category: 'Parfum',
        price: '\$125.00',
        rating: '4.6',
        imageUrl: 'https://cdn.aroma-butik.ru/images/categories/goods_full/1538428060_25588_Giorgio_Armani_c.jpg',
        description:
            'A deep aquatic fragrance with marine notes, incense and patchouli.',
      ),
    ];

class ProductFactory {
  static int _counter = 0;

  static const List<List<String>> _templates = [
    ['Dior Sauvage Elixir', 'Extrait de Parfum', '\$190.00', '4.8', 'A concentrated woody-spicy elixir with cinnamon, nutmeg and licorice.'],
    ['Bleu de Chanel', 'Eau de Parfum', '\$155.00', '4.7', 'A fresh, woody aromatic scent with citrus, incense and cedar.'],
    ['YSL Libre', 'Eau de Parfum', '\$140.00', '4.5', 'A bold floral with lavender, orange blossom and warm vanilla.'],
    ['Byredo Gypsy Water', 'Eau de Parfum', '\$230.00', '4.6', 'A woody, airy fragrance with pine needles, incense and sandalwood.'],
    ['Le Labo Santal 33', 'Eau de Parfum', '\$220.00', '4.7', 'An iconic smoky sandalwood with leather and cedar.'],
    ['Jo Malone Wood Sage & Sea Salt', 'Cologne', '\$105.00', '4.4', 'Windswept shores: ambrette seeds, sea salt and sage.'],
    ['Xerjoff Naxos', 'Eau de Parfum', '\$280.00', '4.9', 'Honey, tobacco, lavender and vanilla in a rich Sicilian blend.'],
    ['Maison Margiela Replica Jazz Club', 'Eau de Toilette', '\$130.00', '4.6', 'Rum, tobacco leaf and vanilla — a smoky night in a jazz bar.'],
  ];

  static Product generate() {
    final t = _templates[_counter % _templates.length];
    _counter++;
    return Product(
      id: 'new_$_counter',
      title: t[0],
      category: t[1],
      price: t[2],
      rating: t[3],
      description: t[4],
      imageUrl: '',
      isNew: true,
    );
  }
}
