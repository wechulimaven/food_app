import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:momentum/momentum.dart';

import 'package:restaurant_app/components/index.dart';
import 'package:restaurant_app/screens/index.dart';
import 'package:restaurant_app/utils/index.dart';
import 'package:scaled_animated_scaffold/scaled_animated_scaffold.dart';

class StartPage extends StatelessWidget {
  final GlobalKey<ScaledAnimatedScaffoldState> _key =
      GlobalKey<ScaledAnimatedScaffoldState>();
  final double _spacer = 20.0;

  static List<Widget> _appScreens = <Widget>[
    HomePage(),
    FavoritesPage(),
    NotificationPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _cartController = Momentum.controller<CartController>(context);

    return RouterPage(
      child: MomentumBuilder(
        controllers: [
          StartPageController,
          CartController,
        ],
        builder: (context, snapshot) {
          final _model = snapshot<StartPageModel>();
          final _cartModel = snapshot<CartModel>();

          return SafeArea(
            child: ScaledAnimatedScaffold(
              key: _key,
              backgroundColor: loginBgColor,
              layerColor: Theme.of(context).primaryColor.withOpacity(0.7),
              appBar: ScaledAnimatedScaffoldAppBar(
                leadingIcon: Icon(
                  Icons.menu,
                  color: textColor,
                ),
                actions: [
                  Spacer(),
                  Center(
                    child: Text(
                      '${_model.appBarTitle ?? ''}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  _model.selectedPageIndex == 3
                      // Show undo & redo buttons when on cart-page
                      ? Container(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.undo),
                                onPressed: () =>
                                    _cartController.undoCartDelete(),
                              ),
                              SizedBox(width: 15),
                              IconButton(
                                icon: Icon(Icons.redo),
                                onPressed: () =>
                                    _cartController.redoCartDelete(),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            right: 15,
                            bottom: 5,
                          ),
                          child: GestureDetector(
                            onTap: () => MomentumRouter.goto(
                              context,
                              ProfilePage,
                            ),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  // FIXME: Add user profile image
                                  fit: BoxFit.contain,
                                  image: AssetImage('assets/images/fire.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              menuConfiguration: ScaledAnimatedScaffoldMenuConfiguration(
                backgroundColor: loginUpperColor.withOpacity(0.8),
                header: Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => _key.currentState.toggleMenu(),
                      child: Container(
                        height: 40,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(
                            LineIcons.close,
                            size: 17,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.heart_o,
                        color: textColor,
                      ),
                      label: Text(
                        'Favorites',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {
                        _key.currentState.toggleMenu();
                        _model.update(
                          selectedPageIndex: 1,
                          appBarTitle: 'My Favorites',
                        );
                      },
                    ),
                    SizedBox(height: _spacer),
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.credit_card,
                        color: textColor,
                      ),
                      label: Text(
                        'Payment Methods',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: _spacer),
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.opencart,
                        color: textColor,
                      ),
                      label: Text(
                        'My Order',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: _spacer),
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.history,
                        color: textColor,
                      ),
                      label: Text(
                        'History',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: _spacer),
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.commenting_o,
                        color: textColor,
                      ),
                      label: Text(
                        'Complaint',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: _spacer),
                    ScaledAnimatedScaffoldMenuButton(
                      icon: Icon(
                        LineIcons.sticky_note,
                        color: textColor,
                      ),
                      label: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ScaledAnimatedScaffoldMenuButton(
                    icon: Transform(
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.logout,
                        color: textColor,
                      ),
                    ),
                    label: Text(
                      'Log out',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              body: _appScreens[_model.selectedPageIndex],
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(25),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _model.update(
                          selectedPageIndex: 0,
                          appBarTitle: '',
                        ),
                        child: Icon(
                          LineIcons.home,
                          color: _model.selectedPageIndex == 0
                              ? buttonBgColor
                              : textColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _model.update(
                          selectedPageIndex: 1,
                          appBarTitle: 'My Favorites',
                        ),
                        child: Icon(
                          LineIcons.heart_o,
                          color: _model.selectedPageIndex == 1
                              ? buttonBgColor
                              : textColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _model.update(
                          selectedPageIndex: 2,
                          appBarTitle: 'Notifications',
                        ),
                        child: Icon(
                          LineIcons.bell,
                          color: _model.selectedPageIndex == 2
                              ? buttonBgColor
                              : textColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _model.update(
                          selectedPageIndex: 3,
                          appBarTitle: 'My Cart',
                        ),
                        child: Badge(
                          showBadge: _cartModel.cart.isEmpty ? false : true,
                          badgeContent: Text(
                            '${_cartModel.cart.length}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Icon(
                            LineIcons.shopping_cart,
                            color: _model.selectedPageIndex == 3
                                ? buttonBgColor
                                : textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
