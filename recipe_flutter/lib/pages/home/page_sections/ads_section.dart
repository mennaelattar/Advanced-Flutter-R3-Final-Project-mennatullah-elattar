import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/models/ad.model.dart';
import 'package:recipe_flutter/providers/ads.provider.dart';
import 'package:recipe_flutter/utilities/colors.dart';

class AdsSection extends StatefulWidget {
  const AdsSection({super.key});

  @override
  State<AdsSection> createState() => _AdsSectionState();
}

class _AdsSectionState extends State<AdsSection> {
  @override
  void initState() {
    Provider.of<AdsProvider>(context, listen: false).providerInit();
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<AdsProvider>(context, listen: false).getAds();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<AdsProvider>(context, listen: false).providerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(builder: (context, adsProviderObj, child) {
      return adsProviderObj.adList == null
          ? CircularProgressIndicator()
          : adsProviderObj.adList!.isEmpty
              ? Text("No Data Found")
              : Stack(
                  children: [
                    CarouselSlider(
                      carouselController:
                          adsProviderObj.buttonCarouselController,
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.4,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        viewportFraction: 0.7,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          adsProviderObj.currentIndexPage = index;
                          setState(() {});
                        },
                      ),
                      items: adsProviderObj.adList!.map((ad) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(ad.image!))),
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 40,
                                decoration:
                                    BoxDecoration(color: ColorApp.mainColor),
                                child: Center(
                                  child: Text(
                                    ad.title!,
                                    style: TextStyle(
                                        backgroundColor: ColorApp.mainColor,
                                        fontSize: 16.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffF55A00)),
                                onPressed: () => adsProviderObj
                                    .buttonCarouselController!
                                    .previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear),
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                            Expanded(flex: 4, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffF55A00)),
                                onPressed: () => adsProviderObj
                                    .buttonCarouselController!
                                    .nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear),
                                child: Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ))
                  ],
                );
    });
  }
}
