import 'package:flutter/material.dart';
import 'package:my_outdoor_footprint/app/data/utils/color_manager.dart';
class HorizontalBarChart extends StatelessWidget {
  const HorizontalBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [
      {
        "units": 50,
        "color": ColorManager.chartPrimary,
      },
      {
        "units": 10,
        "color": ColorManager.chartViolet,
      },
      {
        "units": 70,
        "color": ColorManager.chartYellow,
      },
      {
        "units": 100,
        "color": ColorManager.chartBlue,
      },
    ];
    double maxWidth = MediaQuery.of(context).size.width - 36;
    var totalUnitNum = 0;
    for (int i = 0; i < chartData.length; i++) {
      totalUnitNum = totalUnitNum + int.parse(chartData[i]["units"].toString());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: Row(
          children: [
            for (int i = 0; i < chartData.length; i++)
              i == chartData.length - 1
                  ? Expanded(
                child: SizedBox(
                  height: 16,
                  child: ColoredBox(
                    color: chartData[i]["color"],
                  ),
                ),
              )
                  : Row(
                children: [
                  SizedBox(
                    width:
                    chartData[i]["units"] / totalUnitNum * maxWidth,
                    height: 16,
                    child: ColoredBox(
                      color: chartData[i]["color"],
                    ),
                  ),
                  //const SizedBox(width: 4),
                ],
              )
          ],
        ),
      ),
    );
  }
}
