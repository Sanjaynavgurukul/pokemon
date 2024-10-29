import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/screen/pokemon_detail/pokemon_detail_view_model/pokemon_detail_view_model.dart';
import 'package:pokemon/widget/custom_cashe_image.dart';
import 'package:pokemon/widget/feature_label.dart';
import 'package:provider/provider.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key, required this.item});

  final PokemonItemModel item;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  late PokemonDetailViewModel viewModel;
  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    viewModel = context.watch<PokemonDetailViewModel>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void initializeScroll() {
    _scrollController.addListener(() {
      // Check the scroll offset and change app bar color based on it

      if (_scrollController.offset > 10) {
        if (viewModel.isScrolled) {
          return;
        }
        viewModel.updateHomeScroll(true);
      } else {
        if (!viewModel.isScrolled) {
          return;
        }
        viewModel.updateHomeScroll(false);
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback){
      initializeScroll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: const Color(0xff4A4B4D),
            statusBarIconBrightness:
                viewModel.isScrolled ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                viewModel.isScrolled ? Brightness.dark : Brightness.light),
        backgroundColor:
            viewModel.isScrolled ? Colors.white : Colors.transparent,
        elevation: viewModel.isScrolled ? 2 : 0,
        iconTheme: IconThemeData(
            color: viewModel.isScrolled ? Colors.black : Colors.white),
        centerTitle: true,
        title: !viewModel.isScrolled
            ? null
            : const Text(
                'Pokemon Detail',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    return Container(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [imageSection(), bioSection()],
        ),
      ),
    );
  }

  Widget bioSection() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${widget.item.name}',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Subtype : ${widget.item.supertype}',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.item.subtypes!.length, (index) {
                String item = widget.item.subtypes![index];
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green),
                  child: Text(item),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          FeatureLabel(label: 'Artist',wantPadding: false,),
          Text('${widget.item.artist}'),
          const SizedBox(
            height: 12,
          ),
          FeatureLabel(label: 'Rarity',wantPadding: false,),
          Text('${widget.item.rarity}'),
          const SizedBox(
            height: 12,
          ),
          attacks(),
          const SizedBox(
            height: 12,
          ),
          sets(),

        ],
      ),
    );
  }

  Widget attacks() {
    return Container(
      child: Column(
        children: [
          FeatureLabel(
            label: 'Attacks',
            wantPadding: false,
          ),
          const SizedBox(
            height: 6,
          ),
          Column(
            children: List.generate(widget.item.attacks!.length, (index) {
              PokemonAttack item = widget.item.attacks![index];
              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 6),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Damage : ${item.damage}',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Text(
                      '${item.text}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget sets() {
    return Container(
      child: Column(
        children: [
          FeatureLabel(
            label: 'Sets',
            wantPadding: false,
          ),
          const SizedBox(
            height: 6,
          ),
         Container(
           padding: EdgeInsets.all(12),
           margin: EdgeInsets.only(bottom: 6),
           width: double.infinity,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6),
               border: Border.all(width: 1, color: Colors.grey.shade300)),
           child: Row(
             children: [
               Expanded(flex:2,child:  Container(

                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       '${widget.item.set!.name}',
                       style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: 16),
                     ),
                     const SizedBox(
                       height: 4,
                     ),

                     Text(
                       'Series : ${widget.item.set!.series}',
                       style: TextStyle(
                           color: Colors.grey,
                           fontWeight: FontWeight.normal,
                           fontSize: 12),
                     ),
                     Text(
                       'Printed Total : ${widget.item.set!.printedTotal}',
                       style: TextStyle(
                           color: Colors.grey,
                           fontWeight: FontWeight.normal,
                           fontSize: 12),
                     ),Text(
                       'Total : ${widget.item.set!.total}',
                       style: TextStyle(
                           color: Colors.grey,
                           fontWeight: FontWeight.normal,
                           fontSize: 12),
                     ),
                   ],
                 ),
               )),
             ],
           ),
         )
        ],
      ),
    );
  }


  Widget imageSection() {
    return CustomCacheImage(
      imageUrl: widget.item.image!.large,
      height: 400,
      borderRadius: BorderRadius.zero,
      width: double.infinity,
    );
  }
}
