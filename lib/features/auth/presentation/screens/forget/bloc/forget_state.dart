
import '../../../../../../core/utils/default_values.dart';

final class ForgetState {


  final String email;
  final bool isEmailError;
  final bool isLoading;


  const ForgetState({
    this.email = DefaultValues.string,
    this.isEmailError = DefaultValues.boolean,
    this.isLoading = DefaultValues.boolean,
  });

  ForgetState copyWith({
    String? email,
    bool? isEmailError,
    bool? isLoading,
  }) {
    return ForgetState(
      email: email ?? this.email,
      isEmailError: isEmailError ?? this.isEmailError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [email, isEmailError, isLoading];
}