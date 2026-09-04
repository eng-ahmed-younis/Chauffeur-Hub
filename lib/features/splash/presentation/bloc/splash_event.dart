sealed class SplashEvent {
  const SplashEvent();
  const factory SplashEvent.started() = SplashStarted;
  const factory SplashEvent.updatePressed() = SplashUpdatePressed;
  const factory SplashEvent.updateLaterPressed() = SplashUpdateLaterPressed;
  const factory SplashEvent.errorDismissed() = SplashErrorDismissed;
}

final class SplashStarted extends SplashEvent {
  const SplashStarted();
}

final class SplashUpdatePressed extends SplashEvent {
  const SplashUpdatePressed();
}

final class SplashUpdateLaterPressed extends SplashEvent {
  const SplashUpdateLaterPressed();
}

final class SplashErrorDismissed extends SplashEvent {
  const SplashErrorDismissed();
}
