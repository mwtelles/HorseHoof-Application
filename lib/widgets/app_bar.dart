import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tenorio_app/pages/profile/index.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:tenorio_app/providers/cidade_provider.dart';

class BuildAppBar extends StatefulWidget with PreferredSizeWidget {
  const BuildAppBar(BuildContext context, {Key? key}) : super(key: key);

  @override
  _BuildAppBarState createState() => _BuildAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BuildAppBarState extends State<BuildAppBar> {
  bool _is_loading = false;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = Padding(
      padding: const EdgeInsets.only(top: 27.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              setState(() {
                _is_loading = true;
              });
              await Provider.of<AuthProvider>(context, listen: false)
                  .getUserAuth();
              await Provider.of<CidadeProvider>(context, listen: false)
                  .refreshCidades();
              Get.to(() => const ProfilePage());
            },
            child: Image.asset(
              'assets/logo/LOGO-VERSAO-BASICA.png',
              height: 24.0,
              width: 150.0,
            ),
          ),
        ],
      ),
    );
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60.0,
      actions: <Widget>[
        GestureDetector(
          onTap: () async {
            setState(() {
              _is_loading = true;
            });
            await Provider.of<AuthProvider>(context, listen: false)
                .getUserAuth();
            await Provider.of<CidadeProvider>(context, listen: false)
                .refreshCidades();
            Get.to(() => const ProfilePage());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 14.0, top: 21.0),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) {
                if (_is_loading && provider.user.profileImageUrl.isEmpty) {
                  return const CircularProgressIndicator();
                } else {
                  return CircleAvatar(
                    maxRadius: 35.0,
                    foregroundColor: Colors.blue,
                    backgroundImage:
                        NetworkImage(provider.user.profileImageUrl),
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
              child: const Icon(Icons.logout)),
        ),
      ],
      title: title,
      backgroundColor: Colors.white,
      elevation: 0,
      // iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
