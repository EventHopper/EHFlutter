import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import 'search_fields.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Image.network(
            // "https://gamespot1.cbsistatic.com/uploads/scale_super/1562/15626911/3395984-4.jpg",
            // "https://i.imgur.com/LExq4Bc.gif?noredirect",
            // "https://thumbs.gfycat.com/NecessaryUnawareIguanodon-size_restricted.gif",
            // "https://1.gall-gif.com/hygall/files/attach/images/82/247/028/258/4dc366115a50c84f4d777c333b5a2069.gif",
            // "https://i.pinimg.com/originals/8f/84/0b/8f840b797cb68f26db974945addabc70.gif",
            // "https://78.media.tumblr.com/d3a1bad381be644ff5c5dce3760abcd1/tumblr_p0pkt5RNWE1r7jvayo1_540.gif",
            // "https://media2.giphy.com/media/3oFyD4xKncK6ptR7qg/200.gif",
            // "https://media0.giphy.com/media/TGLt7x4Ppau1oEj21v/giphy.gif",
            // "https://media4.giphy.com/media/1ipKDVkFDsfYf2sxHP/giphy.gif",
            // 'https://cdn.britannica.com/31/94331-050-4B1F71C2/Skyline-Dallas-Texas.jpg', // Dallas, TX
            // 'https://gifimage.net/wp-content/uploads/2018/11/dallas-gif-2.gif', // Dallas, TX
            'https://media2.giphy.com/media/Z69UDgjfRMjsY/giphy.gif', // Los Angeles, CA
            // 'https://64.media.tumblr.com/5a25c032ee8339b170e1c4995a4aba4c/tumblr_ndiq18Ovs21ql8t12o1_500.gifv', // Boston, MA
            fit: BoxFit.cover,
            width: double.infinity,
            height: getProportionateScreenHeight(315),
            filterQuality: FilterQuality.high,
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            child: Container(
              height: getProportionateScreenHeight(315),
              width: double.infinity,
              color: Colors.black,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(80)),
              Text(
                "EventHopper",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(42),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 0.5),
              ),
              Text(
                "Experience more",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Positioned(
            bottom: getProportionateScreenWidth(-25),
            child: SearchField(),
          )
        ],
      ),
    );
  }
}
