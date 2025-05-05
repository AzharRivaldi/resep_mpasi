import 'package:flutter/material.dart';
import 'package:resep_mpasi/page/page_detail_recipes.dart';

import '../model/model_home.dart';

class PageListData extends StatefulWidget {
  final String strKategori;

  const PageListData({super.key, required this.strKategori});

  @override
  State<PageListData> createState() => _PageListDataState();
}

class _PageListDataState extends State<PageListData> {
  late String strKategori;
  String strType = '1';

  var showList = [];

  getData(String kategoriId) async {
    showList = await ModelHome().getListData(strCategories: kategoriId);
    setState(() {});
  }

  @override
  initState() {
    strKategori = widget.strKategori;
    if (strKategori == '6-8 Bulan') {
      strType = '1';
    } else if (strKategori == '9-11 Bulan') {
      strType = '2';
    } else if (strKategori == '12-23 Bulan') {
      strType = '3';
    } else if (strKategori == '>24 Bulan') {
      strType = '4';
    }
    getData(strType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          cacheExtent: double.maxFinite,
          itemCount: showList.length,
          itemBuilder: (context, int index) {
            final item = showList[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              shadowColor: Colors.black26,
              color: const Color(0xffecf3f6),
              margin: const EdgeInsets.all(10),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageDetailRecipes(
                                  strRecipesId: item.strRecipesId.toString(),
                                  strNameMenu: item.strNameMenu.toString(),
                                  strInstruction: item.strInstruction.toString(),
                                  strImageMenu: item.strImageMenu.toString(),
                                  strTime: item.strTime.toString(),
                                  strServings: item.strServings.toString(),
                                  strCalories: item.strCalories.toString(),
                                )
                            )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children: [
                                Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('${item.strImageMenu}'
                                              .replaceAll('assets://recipes/',
                                              'assets/images/')
                                          ),
                                        )
                                    )
                                ),
                                const SizedBox(width: 10),
                                Text('${item.strNameMenu}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ]
                          ),
                          IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: Colors.black,
                              onPressed: () {}
                          )
                        ],
                      )
                  )
              ),
            );
          }),
    );
  }
}
