import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../providers/providers.dart';
import '../widgets/auth_widgets.dart';
import 'forgot_password_screen.dart';
import 'create_account_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'admin@gymname.com');
  final _passwordController = TextEditingController(text: 'password123');
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!mounted) return;

    if (!success) {
      final error = ref.read(authProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(error ?? 'Login failed. Please try again.'),
            ],
          ),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
    // On success: authProvider.isAuthenticated → true → GymFlowRoot rebuilds
    // → MainNavigationShell. No manual Navigator call needed.
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _goToCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    // Hero takes ~42% of screen; card starts at ~36% (overlaps hero bottom)
    final heroHeight = screenHeight * 0.42;
    final cardTopOffset = screenHeight * 0.34;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: [
          // ── Top hero: gym image + gradient + logo ──────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Gym background photo
                Image.asset(
                  'assets/images/login.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                      ),
                    ),
                  ),
                ),
                // Dark overlay — enough contrast for white text, not muddy
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.black.withValues(alpha: 0.70),
                      ],
                    ),
                  ),
                ),
                // Logo + GymFlow + tagline
                SafeArea(
                  child: Center(
                    child: const GymFlowLogo(light: true),
                  ),
                ),
              ],
            ),
          ),

          // ── Scrollable card overlaps the hero bottom ───────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: cardTopOffset,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              child: Center(
                child: AuthCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Card title ─────────────────────────────────
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Please enter your details to sign in.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Email ──────────────────────────────────────
                        AuthTextField(
                          label: 'Email Address',
                          hintText: 'admin@gymname.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.mail_outline_rounded,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // ── Password (with Forgot Password link in label)
                        PasswordField(
                          label: 'Password',
                          hintText: '••••••••',
                          controller: _passwordController,
                          labelTrailing: TextButton(
                            onPressed: _goToForgotPassword,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ── Remember Me ────────────────────────────────
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (val) {
                                  setState(() => _rememberMe = val ?? false);
                                },
                                activeColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Remember Me',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),

                        // ── Sign In Button ─────────────────────────────
                        PrimaryButton(
                          label: 'Sign In',
                          onPressed: _handleLogin,
                          isLoading: authState.isLoading,
                        ),
                        const SizedBox(height: 24),

                        const Divider(color: AppColors.border),
                        const SizedBox(height: 16),

                        // ── Create Account Link ────────────────────────
                        Center(
                          child: AuthFooterLink(
                            prefixText: "Don't have an account? ",
                            linkText: 'Create Account',
                            onTap: _goToCreateAccount,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Copyright ──────────────────────────────────
                        Center(
                          child: Text(
                            '© 2024 GymFlow Inc. All rights reserved.',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
