import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/helper/navigation_helper.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/screen/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon/screen/pokemon_detail/pokemon_detail_view_model/pokemon_detail_view_model.dart';
import 'package:pokemon/screen/search/view_model/search_view_model.dart';
import 'package:pokemon/theme/colors.dart';
import 'package:pokemon/widget/pokemon_card_item.dart';
import 'package:provider/provider.dart';

class PokemonSearch extends StatefulWidget {
  const PokemonSearch({super.key});

  @override
  State<PokemonSearch> createState() => PokemonSearchState();
}

class PokemonSearchState extends State<PokemonSearch> {
  late SearchViewModel viewModel;
  late TextEditingController _textEditingController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Initializing required View model :D
    viewModel = context.watch<SearchViewModel>();
  }

  void closeSearchBox() {
    _focusNode.unfocus();
    _textEditingController.clear();
    // viewModel.search(param: '');
    viewModel.updateSearchOpenStatus(open: false);
  }

  void getTopAsroList() {
    // if (!topListCalled) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     topListCalled = true;
    //     viewModel.getTopAstroList();
    //   });
    // }
  }

  void openSearchBox() {
    _focusNode.requestFocus();
    viewModel.updateSearchOpenStatus(open: true);
  }

  void fetchData() {
    String query = _textEditingController.text;
    if (query.isEmpty) {
      return;
    }

    viewModel.getSearchResponse(query: query.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: IconButton(
          onPressed: () {
            if (viewModel.searchOpen) {
              closeSearchBox();
              return;
            }

            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: searchBox(),
        actions: [
          IconButton(
              onPressed: () {
                if (viewModel.searchOpen) {
                  fetchData();
                  return;
                }

                openSearchBox();
              },
              icon: Icon(
                CupertinoIcons.search,
                size: viewModel.searchOpen ? 22 : 22,
                color: viewModel.searchOpen ? Colors.black : Colors.black,
              )),
        ],
      ),
      body: mainView(),
    );
  }

  Widget searchBox() {
    if (!viewModel.searchOpen) {
      return InkWell(
        onTap: () {
          openSearchBox();
        },
        child: const Text(
          'Type to search',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'linux'),
        ),
      );
    }
    return TextField(
      onChanged: (String? value) {
        if (value != null) {}
      },
      controller: _textEditingController,
      focusNode: _focusNode,
      onSubmitted: (String? value) {
        fetchData();
      },
      autofocus: true,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type to search',
          hintStyle:
              TextStyle(color: Colors.grey.shade500, fontFamily: 'linux')),
    );
  }

  Widget mainView() {
    if (viewModel.showLoader) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (viewModel.pokemonModel == null) {
      return const Center(
        child: Text('Search Pokemon'),
      );
    }

    if (viewModel.pokemonModel!.hasError!) {
      return const Center(
        child: Text('No Data Found'),
      );
    }
    return GridView.builder(
      itemCount: viewModel.pokemonModel!.data!.length,
      padding: const EdgeInsets.all(8),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        PokemonItemModel item = viewModel.pokemonModel!.data![index];
        return PokemonCardItem(
          onClick: (){
            NavigationHelper().navigatePush(context: context, viewModel: PokemonDetailViewModel(), screen: PokemonDetail(item: item));
          },
          item: item,
        );
      },
    );
  }
}
