class DateUtil
{
  static String formatDate( DateTime d ){
    return d.year.toString()+"-"+(d.month < 10 ? "0"+d.month.toString() : d.month.toString())+"-"+(d.day < 10 ? "0"+d.day.toString() : d.day.toString());
  }
}