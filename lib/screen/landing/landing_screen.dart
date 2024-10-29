import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/helper/navigation_helper.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/screen/landing/view_model/landing_view_model.dart';
import 'package:pokemon/screen/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon/screen/pokemon_detail/pokemon_detail_view_model/pokemon_detail_view_model.dart';
import 'package:pokemon/screen/search/search.dart';
import 'package:pokemon/screen/search/view_model/search_view_model.dart';
import 'package:pokemon/widget/custom_cashe_image.dart';
import 'package:pokemon/widget/pokemon_card_item.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static String routeName = '/landing';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late LandingViewModel viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    viewModel = context.watch<LandingViewModel>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      fetchList();
    });
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Check 200 pixels before the end
      viewModel.getPokemonList(fetchMore: true);
    }
  }

  void fetchList() {
    viewModel.getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Pokemon',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationHelper().navigatePush(
                    context: context,
                    viewModel: SearchViewModel(),
                    screen: const PokemonSearch());
              },
              icon: Icon(BootstrapIcons.search /**/)),
          const SizedBox(
            width: 12,
          )
        ],
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset('assets/logo.png'),
        ),
      ),
      body: mainList(),
    );
  }

  Widget mainList() {
    if (viewModel.list == null) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (viewModel.list!.isEmpty) {
      return const Center(
        child: Text('No Data Found'),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      itemCount: viewModel.list!.length,
      padding: const EdgeInsets.all(8),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        PokemonItemModel item = viewModel.list![index];
        return PokemonCardItem(
          onClick: () {
            NavigationHelper().navigatePush(
                context: context,
                viewModel: PokemonDetailViewModel(),
                screen: PokemonDetail(item: item));
          },
          item: item,
        );
      },
    );

    return ListView.builder(
        itemCount: viewModel.list!.length,
        itemBuilder: (context, index) {
          PokemonItemModel item = viewModel.list![index];
          return Text('${item.name}');
        });
  }
}
