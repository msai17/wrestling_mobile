import 'package:wrestling_hub/core/utils/wrestling_copy_clipboard.dart';
import 'package:wrestling_hub/core/utils/wrestling_time_stamp.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/src/presentation/profile/widgets/profile_widget.dart';


class CommentWidget extends StatelessWidget {

  final Comment comment;
  const CommentWidget({super.key,required this.comment});

  bool? isMy() {
    UserData userData = UserData.instance;
    if(!userData.isLogged()!) {
      return false;
    }
    return userData.currentUser!.id == comment.userId!;
  }

  @override
  Widget  build(BuildContext context) {
    bool result = isMy() ?? false;
    return Center(
      child: result ? Align(
        alignment: Alignment.centerRight,
        child: Card(
          margin: const EdgeInsets.all(6),
          color: const Color(0xff2B5278),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onLongPress: () {
              CopyClipBoard().copy(comment.text!, 'Скопировано');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                   padding: const EdgeInsets.only(left: 5.0, right: 10.0,top: 5),
                   child: Text('${comment.text}',style: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Crimson', fontSize: 16))
                 ),
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10.0,bottom: 5),
                      child: Text(WrestlingTimeStamp.timeAgo(comment.creationDateTime.toString()),style: const TextStyle(color: Color(0xff7DA8D3),fontSize: 12))
                  ),
               ],
              ),
          ),
        ),
      ) : InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onLongPress: () {
          CopyClipBoard().copy(comment.text!, 'Скопировано');
        },
        child: Container(
          margin: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileWidget(avatar: comment.avatars,height: 40, width: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff182633),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 5),
                          child: Text('${comment.firstName}',style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber, fontFamily: 'Crimson', fontSize: 14)),
                        ),
                      ),
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                         child: Text('${comment.text}',style: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Crimson', fontSize: 16)),
                       ),
                     ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 10.0,bottom: 5),
                          child: Text(WrestlingTimeStamp.timeAgo(comment.creationDateTime.toString()),style: const TextStyle(color: Color(0xff7DA8D3),fontSize: 12))
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

