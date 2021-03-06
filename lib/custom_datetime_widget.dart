import 'package:datetime_widget/widgets/custom_datepicker.dart';
import 'package:datetime_widget/widgets/custom_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDatetimeWidget extends StatefulWidget {
  final Function onSelect;
  final DateTime startDate;
  final DateTime endDate;

  const CustomDatetimeWidget({Key key, this.onSelect, this.startDate, this.endDate}) : super(key: key);

  @override
  _CustomDatetimeWidgetState createState() => _CustomDatetimeWidgetState();
}

class _CustomDatetimeWidgetState extends State<CustomDatetimeWidget> {
  bool showLoader = false;
  DateTime selectedDate;
  TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.startDate;
    selectedTime = TimeOfDay.fromDateTime(widget.startDate);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLoader) ...[
              Center(
                child: CircularProgressIndicator(),
              ),
            ] else ...[
              SizedBox(
                height: 350,
                child: Row(
                  children: [
                    _drawCalender(context),
                    _drawTimeSelector(context),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: onDateTimeSelect,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius:
                                BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              "Select",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  _drawCalender(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: CustomDatePicker(
        endDate: widget.endDate,
        startDate: widget.startDate,
        onSelect: (DateTime newDate) {
          selectedDate = newDate;
        },
      ),
    );
  }

  _drawTimeSelector(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: CustomTimePicker(
        endDate: widget.endDate,
        startDate: widget.startDate,
        onSelect: (TimeOfDay newTime) {
          selectedTime = newTime;
        },
      ),
    );
  }

  void onDateTimeSelect() {
    widget.onSelect(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute));
    Navigator.pop(context);
  }
}
