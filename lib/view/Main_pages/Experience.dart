import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 50 : 150),
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _isVisible ? 1 : 0,
              child: Text(
                "Professional Experience",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Card 1
            _animatedWrapper(
              delay: 400,
              child: _buildExperienceCard(
                context,
                company: "Transwarranty Finance",
                role: "Mobile Application Developer (Flutter)",
                location: "Kochi, India",
                period: "July 2023 - Present",
                points: [
                  "Developed an agent-based mobile application for a financial services company.",
                  "Enabled features for customers to apply for loans and for merchants to offer financing.",
                  "Built and maintained a high-performance interface using Flutter.",
                ],
                isMobile: isMobile,
              ),
            ),

            const SizedBox(height: 30),

            // Card 2
            _animatedWrapper(
              delay: 600,
              child: _buildExperienceCard(
                context,
                company: "Rootsys International",
                role: "Mobile Application Developer Intern (Flutter)",
                location: "Malappuram, India",
                period: "March 2022 - June 2023",
                points: [
                  "Gained hands-on experience in real-world software projects.",
                  "Worked with modern development frameworks including Flutter and Python.",
                  "Collaborated on innovative software solutions.",
                ],
                isMobile: isMobile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Slide + Fade Animation
  Widget _animatedWrapper({required int delay, required Widget child}) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(top: _isVisible ? 0 : 40),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _isVisible ? 1 : 0,
        child: child,
      ),
    );
  }

  // The actual Card UI logic
  Widget _buildExperienceCard(
      BuildContext context, {
        required String company,
        required String role,
        required String location,
        required String period,
        required List<String> points,
        required bool isMobile,
      }) {
    // Use a local variable to track hover state
    bool isHovered = false;

    return StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              // THE MOVING EFFECT: Moves the card up by 10 pixels when hovered
              transform: isHovered
                  ? (Matrix4.identity()..translate(0, -10, 0))
                  : Matrix4.identity(),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isHovered ? Colors.blueAccent : Colors.grey.shade200,
                  width: 1.5,
                ),
                // THE DEPTH EFFECT: Adds a shadow when hovered
                boxShadow: isHovered
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: isMobile ? double.infinity : 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: isHovered ? Colors.blueAccent : Colors.black87,
                              ),
                            ),
                            Text(
                              "$company | $location",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          period,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  ...points.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.circle, size: 6, color: Colors.blueAccent),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              height: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          );
        }
    );
  }
}