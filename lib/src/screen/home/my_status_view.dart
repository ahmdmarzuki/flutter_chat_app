import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/status_color_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyStatusView extends StatefulWidget {
  final List<Map<String, dynamic>> statusData;
  const MyStatusView({
    Key? key,
    required this.statusData,
  }) : super(key: key);

  @override
  State<MyStatusView> createState() => _MyStatusViewState();
}

class _MyStatusViewState extends State<MyStatusView> {
  final List bgColor = StatusColor().bgColor;
  int currentStatusIndex = 0;

  void deleteStatus() async {
    final service = Provider.of<StatusService>(context, listen: false);

    try {
      await service.deleteStatus(
          widget.statusData[currentStatusIndex]['statusId'], widget.statusData);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(87),
          child: Container(
            height: 87,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: white,
                    radius: 22,
                    child: CircleAvatar(
                      radius: 20,
                      child: Image.asset('assets/image_profile.png'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CostumText(
                    text: 'My Status',
                    color: white,
                    fontSize: FSize().medium,
                  ),
                  Spacer(),
                  IconButton(
                    color: white,
                    onPressed: () {
                      deleteStatus();

                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
            ),
          )),
      backgroundColor:
          bgColor[widget.statusData[currentStatusIndex]['color_code']],
      body: Stack(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (currentStatusIndex != 0) {
                    setState(() {
                      currentStatusIndex--;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  // width: double.infinity,
                  color: bgColor[widget.statusData[currentStatusIndex]
                      ['color_code']],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (currentStatusIndex != widget.statusData.length - 1) {
                    setState(() {
                      currentStatusIndex++;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  // width: double.infinity,
                  color: bgColor[widget.statusData[currentStatusIndex]
                      ['color_code']],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                      child: CostumText(
                          text: widget.statusData[currentStatusIndex]['text'],
                          color: white,
                          fontSize: FSize().big,
                          fontWeight: FWeight().light)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
