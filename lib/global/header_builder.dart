import 'package:best/extensions/transitionless_route.dart';
import 'package:best/global/variables.dart';
import 'package:best/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'menu_builder.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final double currentHeight;
  final double currentWidth;
  final String currentPage;

  const Header(this.currentHeight, this.currentWidth, this.currentPage,
      {Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(currentHeight * 0.075);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      toolbarHeight: currentHeight * 0.075,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // BeST title
          Container(
            margin: EdgeInsets.only(left: currentWidth * 0.022),
            height: (currentHeight * 0.075) * 0.9,
            child: Center(
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(
                      TransitionlessRoute(
                          builder: (context) =>
                              Variables.pageRoutes['Home'] as Widget));
                },
                child: Text(
                  'BeST',
                  style: TextStyle(
                    color: Variables.teal,
                    fontSize: currentWidth > currentHeight
                        ? (currentHeight * 0.075) * 0.5
                        : (currentWidth * 0.05),
                  ),
                ),
              ),
            ),
          ),
          // app logo redirect and login button
          Container(
            margin: EdgeInsets.only(right: currentWidth * 0.02),
            height: (currentHeight * 0.075) * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: (currentHeight * 0.075) * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // app logo
                      Container(
                        margin: EdgeInsets.only(right: currentWidth * 0.005),
                        child: InkWell(
                          onTap: () {
                            Variables.bsRedirect();
                          },
                          child: Image.asset(
                            'images/appLogo.jpg',
                            height: (currentHeight * 0.075) * 0.45,
                          ),
                        ),
                      ),
                      // sign out button
                      Container(
                        margin: EdgeInsets.only(right: currentWidth * 0.008),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Variables.teal,
                            minimumSize: Size(
                              (currentWidth * 0.05),
                              (currentHeight * 0.075) * 0.45,
                            ),
                            maximumSize: Size(
                              (currentWidth * 0.2),
                              (currentHeight * 0.075) * 0.45,
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Variables.user = null;

                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  TransitionlessRoute(
                                      builder: (context) => const BeST()));
                            }
                          },
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: (currentHeight * 0.075) * 0.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...(Variables.pages).map((page) {
                      return Menu(currentWidth, currentHeight, page,
                          page == currentPage ? Variables.teal : Colors.black);
                    }).toList(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
