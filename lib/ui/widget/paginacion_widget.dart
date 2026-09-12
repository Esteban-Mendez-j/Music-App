import 'package:flutter/material.dart';
import 'package:musicapp/ui/view_model/home_view_model.dart';

class PaginacionWidget extends StatelessWidget {
  final HomeViewModel homeViewModel;

  const PaginacionWidget({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (homeViewModel.paginacionReciente.offset > 0)
            ElevatedButton(
              onPressed: homeViewModel.previous,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(14),
                elevation: 4,
              ),
              child: Icon(Icons.chevron_left, size: 28),
            ),
          SizedBox(width: 20),
          if (homeViewModel.paginacionReciente.offset <
              homeViewModel.paginacionReciente.total)
            ElevatedButton(
              onPressed: homeViewModel.next,

              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(14),
                elevation: 4,
              ),
              child: Icon(Icons.chevron_right, size: 28),
            ),
        ],
      ),
    );
  }
}
