import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LocationBanner extends StatefulWidget {
  LocationBanner({
    Key key,
  }) : super(key: key);

  @override
  _LocationBannerState createState() => _LocationBannerState();
}

class _LocationBannerState extends State<LocationBanner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Provider.of<SessionManager>(context, listen: false).nextCity();
      },
      child: Container(
        height: 34,
        width: 206.26,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(0.0, 0.0, 206.3, 34.0),
              size: Size(206.3, 34.0),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: SvgPicture.string(
                _svg_l4quz,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            Pinned.fromSize(
              bounds: Rect.fromLTWH(11.1, 12.0, 184.0, 20.0),
              size: Size(206.3, 40.0),
              pinLeft: true,
              fixedWidth: true,
              fixedHeight: true,
              child: Text(
                Provider.of<SessionManager>(context, listen: true).city,
                style: TextStyle(
                  fontFamily: 'Gibson',
                  fontSize: 14,
                  color: const Color(0xff8592ad),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Pinned.fromSize(
              bounds: Rect.fromLTWH(7.5, 6.4, 14.7, 21.1),
              size: Size(206.3, 34.0),
              pinLeft: true,
              pinTop: true,
              pinBottom: true,
              fixedWidth: true,
              child:
                  // Adobe XD layer: 'Icon material-locat…' (shape)
                  SvgPicture.string(
                _svg_6wxuk7,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_l4quz =
    '<svg viewBox="0.0 0.0 206.3 34.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path  d="M 17.70900344848633 0 L 188.5487976074219 0 C 198.3292083740234 0 206.2578125 7.61115837097168 206.2578125 17 C 206.2578125 26.38884162902832 198.3292083740234 34 188.5487976074219 34 L 17.70900344848633 34 C 7.928589820861816 34 0 26.38884162902832 0 17 C 0 7.61115837097168 7.928589820861816 0 17.70900344848633 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_6wxuk7 =
    '<svg viewBox="7.5 6.4 14.7 21.1" ><path transform="translate(-0.02, 3.42)" d="M 14.87353324890137 3 C 10.79702377319336 3 7.499999523162842 6.297022819519043 7.499999523162842 10.37353324890137 C 7.499999523162842 15.90368270874023 14.87353324890137 24.06723785400391 14.87353324890137 24.06723785400391 C 14.87353324890137 24.06723785400391 22.24706649780273 15.90368270874023 22.24706649780273 10.37353324890137 C 22.24706649780273 6.297022819519043 18.95004272460938 3 14.87353324890137 3 Z M 14.87353324890137 13.00693798065186 C 13.41989612579346 13.00693798065186 12.2401294708252 11.82717227935791 12.2401294708252 10.37353324890137 C 12.2401294708252 8.919894218444824 13.41989612579346 7.740128517150879 14.87353324890137 7.740128517150879 C 16.32717323303223 7.740128517150879 17.50693893432617 8.919894218444824 17.50693893432617 10.37353324890137 C 17.50693893432617 11.82717227935791 16.32717323303223 13.00693798065186 14.87353324890137 13.00693798065186 Z" fill="#665eff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
