extension DurationExtension on Duration {
  String hhmmssFormat() {
    if (this.inHours > 0) {
      return [
        this.inHours.toString().padLeft(2, '0'),
        this.inMinutes.remainder(60).toString().padLeft(2, '0'),
        this.inSeconds.remainder(60).toString().padLeft(2, '0'),
      ].join(":");
    } else {
      return [
        this.inMinutes.remainder(60).toString().padLeft(2, '0'),
        this.inSeconds.remainder(60).toString().padLeft(2, '0'),
      ].join(":");
    }
  }

  String hhmmssSSSFormat() {
    if (this.inHours > 0) {
      return [
            this.inHours.toString().padLeft(2, '0'),
            this.inMinutes.remainder(60).toString().padLeft(2, '0'),
            this.inSeconds.remainder(60).toString().padLeft(2, '0'),
          ].join(":") +
          "." +
          this.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
    } else {
      return [
            this.inMinutes.remainder(60).toString().padLeft(2, '0'),
            this.inSeconds.remainder(60).toString().padLeft(2, '0'),
          ].join(":") +
          "." +
          this.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
    }
  }
}
