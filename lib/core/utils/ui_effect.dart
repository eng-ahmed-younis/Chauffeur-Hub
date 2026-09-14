/// A general UI side-effect enum used across BLoC states for one-time actions
/// like navigation or displaying error messages.
enum UiEffect {
  none,
  navigate,
  showError,
}
