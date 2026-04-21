import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view/WebPortfolioPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _slideAnim;

  static const Color primaryPurple = Color(0xFF5B3BE5);
  static const Color deepPurple = Color(0xFF3D1FCC);
  static const Color lightPurple = Color(0xFF7C5BF0);
  static const Color accentCyan = Color(0xFF00D4FF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMedium = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6, curve: Curves.easeOut)),
    );
    _scaleAnim = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6, curve: Curves.elasticOut)),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 1, curve: Curves.easeOut)),
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => const WebPortfolioPage(),
        //     transitionsBuilder: (_, anim, __, child) =>
        //         FadeTransition(opacity: anim, child: child),
        //     transitionDuration: const Duration(milliseconds: 500),
        //   ),
        // );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [deepPurple, primaryPurple,lightPurple],
          ),
        ),
        child: Stack(
          children: [
            // Background geometric shapes
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -80,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:accentCyan.withOpacity(0.15),
                ),
              ),
            ),
            // Center content
            Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SummaryCard(title: "sumbit",color:accentCyan,icon: Icons.import_contacts,amount: "200",),
                      // Container(
                      //   width: 100,
                      //   height: 100,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.15),
                      //     borderRadius: BorderRadius.circular(28),
                      //     border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                      //   ),
                      //   child: const Icon(
                      //     Icons.receipt_long_rounded,
                      //     color: Colors.white,
                      //     size: 52,
                      //   ),
                      // ),
                      const SizedBox(height: 28),
                      SlideTransition(
                        position: _slideAnim,
                        child: Text(
                          'BillPro',
                          style: GoogleFonts.poppins(
                            fontSize: 44,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SlideTransition(
                        position: _slideAnim,
                        child: Text(
                          'Smart Billing & Invoicing',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.75),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom tagline
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.6),
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading your workspace...',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({required this.title, required this.amount, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 11, color: Color(0xFF6B7280))),
                Text(amount, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}