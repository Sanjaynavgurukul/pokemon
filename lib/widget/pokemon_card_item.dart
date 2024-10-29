import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/helper/navigation_helper.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/widget/custom_cashe_image.dart';

class PokemonCardItem extends StatelessWidget {
  const PokemonCardItem({super.key, required this.item,required this.onClick});

  final PokemonItemModel item;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: mainView(),
    );
  }

  Widget mainView(){
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Stack(
          children: [
            CustomCacheImage(
              imageUrl: item.image!.small,
              borderRadius: BorderRadius.circular(12),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black54),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${item.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
