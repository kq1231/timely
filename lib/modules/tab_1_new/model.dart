class Progress {
  late final List<int> hours;
  late final int points;
  late final int level;
  late final Map<String, DateTime> paused;
  late final List<String> stopped;

  Progress({
    required this.hours,
    required this.points,
    required this.level,
    required this.paused,
    required this.stopped,
  });

  Progress copyWith({
    List<int>? hours,
    int? points,
    int? level,
    Map<String, DateTime>? paused,
    List<String>? stopped,
  }) {
    return Progress(
      hours: hours ?? this.hours,
      points: points ?? this.points,
      level: level ?? this.level,
      paused: paused ?? this.paused,
      stopped: stopped ?? this.stopped,
    );
  }

  toJson() => {
        'hours': hours,
        'points': points,
        'level': level,
        'paused': paused,
        'stopped': stopped,
      };

  Progress.fromJson(json) {
    hours = json['hours'].cast<int>();
    points = json['points'];
    level = json['level'];
    paused = json['paused'] as Map<String, DateTime>;
    stopped = json['stopped'].cast<int>();
  }

  @override
  String toString() {
    return 'Progress(hours: $hours, points: $points, level: $level, paused: $paused, stopped: $stopped)';
  }
}
