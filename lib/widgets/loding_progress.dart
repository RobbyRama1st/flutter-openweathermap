import 'package:flutter/material.dart';

void onLoading(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await showGeneralDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierLabel: 'test',
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 500),
        transitionBuilder: (context, a1, a2, widget) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Color(0xff00A1FF),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Getting weather...',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
  });
}
