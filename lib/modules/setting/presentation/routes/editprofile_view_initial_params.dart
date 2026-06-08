class EditprofileViewInitialParams {
  final String fullname;
  final String userName;
  final String email;
  final String? dob;
  const EditprofileViewInitialParams({
    required this.fullname,
    required this.userName,
    required this.email,
    this.dob,
  });

  factory EditprofileViewInitialParams.fromUri(Uri uri) {
    return EditprofileViewInitialParams(fullname: '', userName: '', email: ''
      // Parse the URI parameters as needed
    );
  }
}
