import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.notification,
        type: AppBarType.notification,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: const <Widget>[
          Card(
              child: ListTile(
                  title: Text("Battery Full"),
                  subtitle: Text("The battery is full."),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                  trailing: Icon(Icons.star))),
          Card(
              child: ListTile(
                  title: Text("Anchor"),
                  subtitle: Text("Lower the anchor."),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                  trailing: Icon(Icons.star))),
          Card(
              child: ListTile(
                  title: Text("Alarm"),
                  subtitle: Text("This is the time."),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                  trailing: Icon(Icons.star))),
          Card(
              child: ListTile(
                  title: Text("Ballot"),
                  subtitle: Text("Cast your vote."),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                  trailing: Icon(Icons.star)))
        ],
      ),
    );
  }
}
