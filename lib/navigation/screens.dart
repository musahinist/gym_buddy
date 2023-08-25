enum Screens {
  landing("/landing", "Landing"),
  search("/search", "Search"),
  workout("/workout", "Workout ");

  const Screens(this.path, this.name);
  final String path;
  final String name;
}
