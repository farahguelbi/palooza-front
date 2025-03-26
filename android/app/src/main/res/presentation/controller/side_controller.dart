import 'package:flutter/scheduler.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/sides.dart';
import 'package:front/domain/usecases/side_usecases/get_all_sides.dart';
import 'package:front/domain/usecases/side_usecases/get_side_by_id.dart';
import 'package:get/get.dart';

class SideController extends GetxController {
  
   List<Side> AllSides = [];
  List<Side> SidesList = [];
  bool isLoading = false;
  String msg = '';
  Side ?selectedSide;
   Future<bool> getAllsides() async {
    isLoading = true;
  _safeUpdate();
    final res = await GetAllSidesUseCase(sl())();
    isLoading = false;
   _safeUpdate();
    res.fold(
      (failure) {
        msg = 'Failed to load products';
        AllSides=[];
     _safeUpdate();
        return false;
      },
      (sides) {
        AllSides = sides;
        msg = '';
      _safeUpdate();
        return true;
      },
    );
    return true;
  }
  // Fetch a single product by ID
  Future<bool> getSideById(String id) async {
    isLoading = true;
_safeUpdate();
    final res = await GetSideById(sl())( id);
    isLoading = false;
_safeUpdate();
    res.fold(
      (failure) {
              print("Failed to fetch side: ${failure.message}");

        msg = 'Product not found';
        selectedSide=null;
        _safeUpdate();
        return false;
      },
      (side) {
              print("Fetched side: ${side.name}");

        selectedSide = side;
        msg = '';
       _safeUpdate();
        return true;
     
      },

    );
    return true;
}
 void _safeUpdate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }
}