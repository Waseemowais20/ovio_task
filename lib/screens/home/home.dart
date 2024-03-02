// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../general_exports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.getWeatherDetails();
          },
          child: Scaffold(
            backgroundColor: Color(AppColors.blue2).withOpacity(0.9),
            body: controller.weatherDetailsModel == null || controller.isLoading
                ? const Center()
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: DEVICE_WIDTH * 0.05,
                      vertical: DEVICE_HEIGHT * 0.07,
                    ),
                    child: SizedBox(
                      width: DEVICE_WIDTH,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('EEEE, d MMMM y').format(
                                  controller.weatherDetailsModel?.data?[0]
                                          .coordinates?[0].dates?[0].date ??
                                      DateTime.now(),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Color(AppColors.white),
                                    ),
                              ),
                              TemperatureDropdown(
                                  controller.selectedTemperature,
                                  controller.changeTemperature)
                            ],
                          ),
                          HomeHeader(),
                          Column(
                            children: [
                              SizedBox(
                                height: DEVICE_HEIGHT * 0.02,
                              ),
                              Container(
                                padding: EdgeInsets.all(DEVICE_WIDTH * 0.05),
                                decoration: BoxDecoration(
                                  color:
                                      Color(AppColors.blue4).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                      DEVICE_WIDTH * 0.02),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      getWeatherDescription(
                                          controller.cordinates?[0].dates?[0]
                                                  .value ??
                                              0,
                                          controller.selectedTemperature ==
                                              'C'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Color(AppColors.white),
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          WeeklyReport(),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return Column(
          children: [
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            Text(
              controller.placeMarks?[0].locality ?? '',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(AppColors.white),
                  ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: DEVICE_WIDTH * 0.02,
                ),
                Text(
                  '${controller.cordinates?[0].dates?[0].value ?? 0}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 30, color: Color(AppColors.white)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.01),
                  child: Icon(
                    Icons.circle_outlined,
                    size: DEVICE_HEIGHT * 0.02,
                    weight: DEVICE_WIDTH * 0.02,
                    color: Color(AppColors.white),
                  ),
                ),
              ],
            ),
            Lottie.asset(weatherLottie),
            Text(
              controller.placeMarks?[0].subLocality ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(AppColors.white),
                  ),
            ),
            Text(
              controller.placeMarks?[0].thoroughfare ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(AppColors.white),
                  ),
            ),
          ],
        );
      },
    );
  }
}

class TemperatureDropdown extends StatelessWidget {
  final String selectedTemperature;
  final Function(String) onTemperatureChanged;

  TemperatureDropdown(this.selectedTemperature, this.onTemperatureChanged);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedTemperature,
      onChanged: (String? newValue) {
        onTemperatureChanged(newValue!);
      },
      dropdownColor: Color(AppColors.blue4),
      items: <String>['C', 'F'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Color(AppColors.white),
                ),
          ),
        );
      }).toList(),
    );
  }
}

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return SizedBox(
          height: DEVICE_HEIGHT,
          width: DEVICE_WIDTH,
          child: GridView.builder(
              itemCount: controller.dates.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: DEVICE_HEIGHT * 0.02,
                crossAxisSpacing: DEVICE_WIDTH * 0.02,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(AppColors.white).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index != 0
                            ? DateFormat('EEEE, d MMMM').format(
                                controller.dates[index].date!,
                              )
                            : 'Tomorrow',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Color(AppColors.white),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.02,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: DEVICE_WIDTH * 0.02,
                          ),
                          Text(
                            '${controller.dates[index].value ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 30,
                                    color: Color(AppColors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: DEVICE_WIDTH * 0.01),
                            child: Icon(
                              Icons.circle_outlined,
                              size: DEVICE_HEIGHT * 0.02,
                              weight: DEVICE_WIDTH * 0.02,
                              color: Color(AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
