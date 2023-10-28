class SyncProgressModel {
  final String title;
  final int counter;
  final int total;
  final int percent;
  final int totalAccesorias;

  SyncProgressModel(
      {required this.title,
      this.total = 0,
      required this.counter,
      required this.percent,
      this.totalAccesorias = 73});

  SyncProgressModel copyWith(
          {String? title, int? counter, int? total, int? percent}) =>
      SyncProgressModel(
          title: title ?? this.title,
          total: total ?? this.total,
          counter: counter ?? this.counter,
          percent: percent ?? this.percent);
}
