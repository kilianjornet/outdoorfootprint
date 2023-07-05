import 'package:get/get.dart';

class TipsController extends GetxController {
  dynamic list = [
    {
      'title': 'When you go to the mountains',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pulvinar, lorem vitae mattis tincidunt, sem nisi efficitur quam, eget suscipit.'
    },
    {
      'title': 'When eating',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur semper maximus varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consectetur at mi ac convallis. Nunc aliquet, mauris sit.'
    },
    {
      'title': 'When shopping',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam id nisl neque. In et lorem et tortor interdum tincidunt. Sed sed iaculis velit. Etiam vitae velit eget erat mollis rhoncus eget quis elit. Nulla tincidunt luctus mauris non accumsan. Pellentesque.'
    },
    {
      'title': 'At home',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in risus eu erat vestibulum cursus ut non massa. Nam maximus commodo orci, eu tincidunt arcu.'
    },
  ];
  late List<RxBool> boolList = List.generate(list.length, (index) => false.obs);
  late List<RxBool> isPressed =
      List.generate(list.length, (index) => false.obs);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleExpand(int index) {
    boolList[index].value = !boolList[index].value;
  }
}
