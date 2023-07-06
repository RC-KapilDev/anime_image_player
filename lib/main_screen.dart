import 'package:flutter/material.dart';
import 'package:wifu/wifu_images.dart';

class wifu extends StatefulWidget {
  const wifu({super.key});

  @override
  State<wifu> createState() => _wifuState();
}

class _wifuState extends State<wifu> {
  String imageUrl = '';
  SFW selected = SFW.waifu;
  Category? category = Category.SFW;
  NSFW nsfw = NSFW.neko;

  void getimageUrl(String item, Category? cat) async {
    String c;
    Category.NSFW == cat ? c = 'nsfw' : c = 'sfw';
    imageUrl = await WifuImg().imageWifu(item, c);
    setState(() {});
  }

  @override
  void initState() {
    getimageUrl(selected.name, category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WAIFU'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Download'),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: imageUrl.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      imageUrl,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tap the Button If it takes Long"),
                      SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                      value: category,
                      items: Category.values
                          .map((items) => DropdownMenuItem(
                              value: items,
                              child: Text(items.name.toUpperCase())))
                          .toList(),
                      onChanged: (values) {
                        setState(() {
                          category = values;
                        });
                      }),
                  dropDown(),
                  Center(
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            getimageUrl(selected.name, category);
                          },
                          label: const Text('Next'))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownButton dropDown() {
    if (category == Category.NSFW) {
      return DropdownButton(
        value: nsfw,
        items: NSFW.values
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item.name.toUpperCase()),
                ))
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            nsfw = value;
          });
        },
      );
    } else {
      return DropdownButton(
        value: selected,
        items: SFW.values
            .map((category) => DropdownMenuItem(
                value: category, child: Text(category.name.toUpperCase())))
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            selected = value;
          });
        },
      );
    }
  }
}
