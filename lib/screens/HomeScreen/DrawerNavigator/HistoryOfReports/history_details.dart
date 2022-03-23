import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/HistoryOfReports/data_history_model.dart';
import 'package:flutter/material.dart';

class HistoryDetails extends StatelessWidget {
  final DataHistoryModel dataHistoryModel;
  const HistoryDetails({Key? key, required this.dataHistoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataHistoryModel.emergencyTypeOfReport.toString(),
          style: const TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Color.fromARGB(255, 216, 188, 188),
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(dataHistoryModel.emergencyTypeOfReport.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(dataHistoryModel.description.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(dataHistoryModel.dateAndTime.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(dataHistoryModel.imageUrl.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(dataHistoryModel.address.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(dataHistoryModel.location.toString()),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
