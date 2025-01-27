import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/not_logged_in_screen.dart';
import 'package:farmacie_stilo/view/screens/order/widget/order_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      Get.find<OrderController>().getRunningOrders(1);
      Get.find<OrderController>().getHistoryOrders(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: 'my_orders'.tr,
          backButton: ResponsiveHelper.isDesktop(context)),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: _isLoggedIn
          ? GetBuilder<OrderController>(
              builder: (orderController) {
                return Column(children: [
                  Center(
                    child: Container(
                      width: Dimensions.webMaxWidth,
                      color: Theme.of(context).cardColor,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Color(0xff1a3922),
                        indicatorWeight: 3,
                        labelColor: Color(0xff1a3922),
                        unselectedLabelColor: Theme.of(context).disabledColor,
                        unselectedLabelStyle: robotoRegular.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: Dimensions.fontSizeSmall),
                        labelStyle: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).primaryColor),
                        tabs: [
                          Tab(text: 'running'.tr),
                          Tab(text: 'history'.tr),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: const [
                      OrderView(isRunning: true),
                      OrderView(isRunning: false),
                    ],
                  )),
                ]);
              },
            )
          : const NotLoggedInScreen(),
    );
  }
}
