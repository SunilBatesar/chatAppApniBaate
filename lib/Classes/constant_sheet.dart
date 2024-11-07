import 'package:recipe_test/Res/Apis/apis.dart';
import 'package:recipe_test/components/Constants/style_sheet.dart';

class ConstantSheet {
  ConstantSheet._constructor();
  static final ConstantSheet instance = ConstantSheet._constructor();

  factory ConstantSheet() {
    return instance;
  }
  AppColors get colors => AppColors();
  AppTextTheme get textTheme => AppTextTheme();
  Apis get apis => Apis();
}
