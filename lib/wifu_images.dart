import 'dart:convert';
import 'package:http/http.dart' as http;

enum Category { SFW, NSFW }

enum SFW {
  waifu,
  neko,
  shinobu,
  megumin,
  bully,
  cuddel,
  cry,
  hug,
  awoo,
  kiss,
  lick,
  pat,
  smug,
  bonk,
  yeet,
  blush,
  smile,
  wave,
  highfive,
  handhold,
  nom,
  bite,
  glomp,
  slap,
  kill,
  kick,
  happy,
  wink,
  poke,
  dance,
  cringe,
}

enum NSFW {
  waifu,
  neko,
  trap,
  blowjob,
}

class WifuImg {
  String imageUrl = '';
  Future imageWifu(String type, String category) async {
    http.Response response =
        await http.get(Uri.parse('https://waifu.pics/api/$category/$type'));
    if (response.statusCode == 200) {
      var imageLink = jsonDecode(response.body);
      imageUrl = imageLink['url'];
      return imageUrl;
    } else {
      throw Exception('Failed to fetch image URL');
    }
  }
}
