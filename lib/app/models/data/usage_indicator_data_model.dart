class UsageIndicatorDataModel {
  final int id;
  final String passName;
  final DateTime passDate;
  final int passRemainingTime;
  final int tickets;

  UsageIndicatorDataModel({
    required this.id,
    required this.passName,
    required this.passDate,
    required this.passRemainingTime,
    required this.tickets,
  });
}
