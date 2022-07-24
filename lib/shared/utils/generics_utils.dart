class GenericsUtils {
  static T? cast<T>(x) {
    if (x is T) {
      return x;
    } else {
      return null;
    }
  }
}
