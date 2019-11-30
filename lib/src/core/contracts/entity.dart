abstract class Entity<T> {
  T copyWith();
  String toString();
  bool operator == (object);
  int get hashCode;
}
