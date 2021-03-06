import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class LocaleMenu extends StatelessWidget {
  const LocaleMenu({Key? key}) : super(key: key);

  Widget renderNotificationIcon(friendshipRequests) {
    return Stack(
        children: <Widget>[
            const Icon(Icons.notifications),
            if (friendshipRequests.isNotEmpty) Positioned(
                right: 0,
                top: 0,
                child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                        '${friendshipRequests.length}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                    ),
                ),
            )
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
      return PopupMenuButton(
          icon: const Icon(Icons.translate),
          onSelected: (e) => { MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: e as String)) },
          itemBuilder: (BuildContext context) {
              return ['en', 'ru'].map((e) =>
                  PopupMenuItem(
                      value: e,
                      child: Text(e)
                  )
              ).toList();
          }
      );
    }
}
