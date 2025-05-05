import 'package:flutter/material.dart';

import '../model/model_home.dart';

class PageDetailRecipes extends StatefulWidget {
  final String? strRecipesId;
  final String? strNameMenu;
  final String? strInstruction;
  final String? strImageMenu;
  final String? strTime;
  final String? strServings;
  final String? strCalories;

  const PageDetailRecipes(
      {super.key,
      this.strRecipesId,
      this.strNameMenu,
      this.strInstruction,
      this.strImageMenu,
      this.strTime,
      this.strServings,
      this.strCalories});

  @override
  State<PageDetailRecipes> createState() => _PageDetailRecipesState();
}

class _PageDetailRecipesState extends State<PageDetailRecipes> {
  late String strRecipesId, strNameMenu, strInstruction,
      strImageMenu, strTime, strServings, strCalories;

  var showList;

  getData(String recipesId) async {
    showList = await ModelHome().getRecipes(strRecipesId: recipesId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    strRecipesId = widget.strRecipesId!;
    strNameMenu = widget.strNameMenu!;
    strInstruction = widget.strInstruction!;
    strImageMenu = widget.strImageMenu!;
    strTime = widget.strTime!;
    strServings = widget.strServings!;
    strCalories = widget.strCalories!;

    getData(strRecipesId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            strNameMenu.toString(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.sizeOf(context).width * 0.26,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                  ),
                  color: Color(0xffffe1e1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.timelapse),
                        color: const Color(0xffec2d2d),
                        onPressed: () {}
                    ),
                    Text('$strTime menit',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffec2d2d),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                width: MediaQuery.sizeOf(context).width * 0.35,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                  ),
                  color: Color(0xffd0ffdb),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.groups),
                        color: const Color(0xff2a7e2f),
                        onPressed: () {}
                    ),
                    Text('Untuk $strServings porsi',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff2a7e2f),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  ),
                  color: Color(0xfffdd835),
                ),
                height: MediaQuery.sizeOf(context).height * 0.60,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 14, left: 10),
                        child: Text('Bahan-bahan:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: showList.length,
                          itemBuilder: (context, int index) {
                            final item = showList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('${item.strIngredients}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )
                              ),
                            );
                          }
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Cara membuat:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 10, 10, 20
                        ),
                        child: Text(strInstruction,
                            style: const TextStyle(
                              fontSize: 14,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -90,
              child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(strImageMenu.replaceAll(
                            'assets://recipes/', 'assets/images/')
                        ),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 10,
                      ),
                    ],
                  )
              ),
            ),
          ],
        )
    );
  }
}
