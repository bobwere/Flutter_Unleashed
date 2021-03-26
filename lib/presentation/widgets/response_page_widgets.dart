import 'package:flutter/material.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';
import 'package:flutter_unleashed/presentation/widgets/shared/loading_indicator.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

const responsePageTextStyle = TextStyle(
    color: Color(0xFF222222),
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500);

class Loader extends StatelessWidget {
  const Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Center(
        child: BallChasingLoadingIndicator(
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}

class DataFetchingErrorWidget extends StatelessWidget {
  const DataFetchingErrorWidget(
      {Key key, @required this.errorMessage, @required this.onPressed})
      : super(key: key);
  final String errorMessage;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 6.4,
              child: Image.asset(
                errorMessage == 'poor or no internet connection'
                    ? 'assets/images/no_internet.png'
                    : 'assets/images/server_failure.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              errorMessage == 'poor or no internet connection'
                  ? 'Poor or no internet connection\nKindly Retry'
                  : 'server failure occurred',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF202020),
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  textStyle: textStyle.copyWith(color: Color(0xFFFFFFF)),
                  primary: Colors.white,
                  backgroundColor: Color(0xFF4268FF),
                  onSurface: Colors.grey,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                child: Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterByDropDown extends StatefulWidget {
  FilterByDropDown(
      {Key key,
      @required this.items,
      @required this.onItemSelected,
      @required this.width,
      @required this.hintText})
      : super(key: key);
  final List<String> items;
  final Function(String value) onItemSelected;
  final double width;
  final String hintText;

  @override
  _FilterByDropDownState createState() => _FilterByDropDownState();
}

class _FilterByDropDownState extends State<FilterByDropDown> {
  String filterBy;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            key: const Key('filterbydropdown'),
            value: filterBy,
            isExpanded: true,
            icon: Icon(
              LineAwesomeIcons.chevron_circle_down,
              size: 17,
              color: Color(0xFF222222),
            ),
            hint: Text(
              widget.hintText,
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            items: [...widget.items]
                .map(
                  (filterBy) => DropdownMenuItem(
                    value: filterBy,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$filterBy',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                filterBy = value;
              });
              widget.onItemSelected(value);
            }),
      ),
    );
  }
}
