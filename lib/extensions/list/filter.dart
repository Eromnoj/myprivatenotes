// extension to the Stream class
// it allows to filter objects from a List of another list of that objects, depending on an
// arguments of those objects.
extension Filter<T> on Stream<List<T>> {
  // take the list/ apply the filter method on that list
  Stream<List<T>> filter(bool Function(T) where) =>
      map((items) => items.where(where).toList());
}
