import 'package:intl/intl.dart';


String capitalize(String? string) {
  return (string is Null || string == '') ? '': string[0].toUpperCase() + string.substring(1);
}

String? formatDate(String? date) {
  return date is Null ? date : DateFormat('dd/MM/yyyy').format(DateTime.parse(date).toLocal());
}

String? formatDateTime(String? datetime) { 
  return datetime is Null ? datetime : DateFormat('dd/MM/yyyy hh:mm:ss').format(
    DateTime.parse(datetime.toString()).toLocal()
  );
}

String? formatPhone(dynamic phone) => phone is Null ? phone : '0' + phone.toString();
