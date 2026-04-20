import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/local_storage_service.dart';
import 'main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Drop keyboard focus instantly to ensure validation snackbars are visible
    FocusManager.instance.primaryFocus?.unfocus();

    // Validate string constraints (length, characters, spaces)
    if (_formKey.currentState!.validate()) {
      // Persist credentials locally before transitioning to the app shell
      final localStorageService = LocalStorageService();
      await localStorageService.saveCredentials(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const MainShell()));
      }
    }
  }

  void _showErrorPopup(String message) {
    // Explicitly drop focus to prevent the keyboard from obscuring the feedback popup
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: GestureDetector(
        // Automatically dismiss the keyboard when tapping anywhere in the background
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 64),

                  // Logo
                  SvgPicture.asset(
                    'assets/images/kora-logo.svg',
                    width: 88,
                    height: 88,
                  ),
                  const SizedBox(height: 24),

                  // Welcome text
                  Text(
                    'Welcome!',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: const Icon(
                        Icons.mail_outline,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (value.contains(' ')) {
                        return 'Email cannot contain spaces';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _showErrorPopup(
                        'Forgot password module is not ready yet.',
                      ),
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _handleLogin,
                      icon: const Icon(Icons.login, size: 20),
                      label: const Text('Log in'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // OR divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.border)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.border)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Google
                  _SocialLoginButton(
                    label: 'Continue with Google',
                    icon: 'G',
                    iconColor: AppColors.primary,
                    onPressed: () => _showErrorPopup(
                      'This login option is not available yet.',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Facebook
                  _SocialLoginButton(
                    label: 'Continue with Facebook',
                    icon: '',
                    iconWidget: const Icon(
                      Icons.facebook,
                      size: 20,
                      color: Colors.blue,
                    ),
                    onPressed: () => _showErrorPopup(
                      'This login option is not available yet.',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Apple
                  _SocialLoginButton(
                    label: 'Continue with Apple',
                    icon: '',
                    iconWidget: const Icon(
                      Icons.apple,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => _showErrorPopup(
                      'This login option is not available yet.',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () =>
                            _showErrorPopup('Sign up module is not ready yet.'),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final String icon;
  final Color? iconColor;
  final Widget? iconWidget;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.label,
    this.icon = '',
    this.iconColor,
    this.iconWidget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconWidget != null)
              iconWidget!
            else
              Text(
                icon,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: iconColor ?? AppColors.textPrimary,
                ),
              ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
