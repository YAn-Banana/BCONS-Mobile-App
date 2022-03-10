import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetAge extends StatefulWidget {
  const GetAge({Key? key}) : super(key: key);

  @override
  _GetAgeState createState() => _GetAgeState();
}

class _GetAgeState extends State<GetAge> {
  DateTime initialDate = DateTime.now();
  DateTime? date;
  String textSelect = 'Press to Select your Birthday';
  int? day = 0;

  //Show Date Picker
  Future<void> selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (newDate == null) return;
    if (newDate != initialDate) {
      setState(() {
        date = newDate;
        day = findDays(date!.month, date!.year)!;
      });
    }
  }

  // logic to get date, instance from the date picker
  String getDate() {
    if (date == null) {
      return textSelect;
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
    }
  }

  int? findDays(int month, int year) {
    int day2;
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      return day2 = 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return day2 = 30;
    } else {
      if (year % 4 == 0) {
        return day2 = 29;
      } else {
        return day2 = 28;
      }
    }
  }

  String? getAge() {
    if (date == null) {
      return null;
    } else {
      int ageYear;
      int ageMonth;
      int ageDays;
      int yearNow = initialDate.year;
      int monthNow = initialDate.month;
      int dayNow = initialDate.day;
      int birthYear = date!.year;
      int birthMonth = date!.month;
      int birthDay = date!.day;

      if (dayNow - birthDay >= 0) {
        ageDays = (dayNow - birthDay);
      } else {
        ageDays = ((dayNow + day!) - birthDay);
        monthNow = monthNow - 1;
      }
      if (monthNow - birthMonth >= 0) {
        ageMonth = (monthNow - birthMonth);
      } else {
        ageMonth = ((monthNow + 12) - birthMonth);
        yearNow = yearNow - 1;
      }
      yearNow = (yearNow - birthYear);
      ageYear = yearNow;

      return '$ageYear, $ageMonth, $ageDays';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    selectDate(context);
                  },
                  child: const Text('Select')),
              const SizedBox(
                height: 10,
              ),
              Text(getDate()),
              const SizedBox(
                height: 10,
              ),
              Text('${getAge()}')
            ],
          ),
        ),
      ),
    );
  }
}
