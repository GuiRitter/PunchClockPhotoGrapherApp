bool setEquals(Set a, Set b) {
  if (a.length != b.length) {
    return false;
  }

  return a.containsAll(
    b,
  );
}
