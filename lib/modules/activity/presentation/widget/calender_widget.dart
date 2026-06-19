import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';

class BookingCalenderWidget extends StatefulWidget {
  const BookingCalenderWidget({super.key});

  @override
  State<BookingCalenderWidget> createState() => _BookingCalenderWidgetState();
}

class _BookingCalenderWidgetState extends State<BookingCalenderWidget> {
  DateTime todayDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  void onSelectDate(DateTime selectDay, DateTime focusDay) {
    setState(() {
      focusedDay = focusDay; // ✅ IMPORTANT

      if (startDate == null || (startDate != null && endDate != null)) {
        startDate = selectDay;
        endDate = null;
      } else if (selectDay.isAfter(startDate!)) {
        endDate = selectDay;
      } else {
        startDate = selectDay;
      }
    });
  }

  bool isInRange(DateTime day) {
    if (startDate == null || endDate == null) return false;
    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          onPageChanged: (newFocusedDay) {
            focusedDay = newFocusedDay; // ✅ update month
          },
          selectedDayPredicate: (day) =>
              isSameDay(startDate, day) || isSameDay(endDate, day),
          onDaySelected: onSelectDate,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            rangeHighlightColor: Colors.deepPurple.shade100,
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              if (isInRange(day)) {
                return Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('${day.day}'),
                );
              }
              return null;
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
        20.heightBox,
        AppButton(
          onTap: () {
            context.popPage({"startDate": startDate, "endDate": endDate});
          },
          title: "Save",
        ),
      ],
    );
  }
}
