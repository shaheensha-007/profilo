import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui'; // For BackdropFilter

class WebPortfolioPage extends StatefulWidget {
  const WebPortfolioPage({super.key});

  @override
  State<WebPortfolioPage> createState() => _WebPortfolioPageState();
}

class _WebPortfolioPageState extends State<WebPortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Color Palette
  final Color primaryColor = const Color(0xFF2563EB); // Royal Blue
  final Color secondaryColor = const Color(0xFF1E293B); // Dark Slate
  final Color bgColor = const Color(0xFFF8FAFC); // Very Light Grey

  // Add url_launcher to pubspec.yaml

  void _downloadCV() async {
    final Uri url = Uri.parse('https://drive.google.com/file/d/1RGXMPVa0CGiOCZEnFiMvLuId0iJsMLFP/view?usp=drive_link');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }






  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildGlassAppBar(isDesktop),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(width, isDesktop),
            _buildSectionTitle("Experience"),
            _buildExperienceSection(isDesktop),
            _buildSectionTitle("Tech Stack"),
            _buildSkillsSection(width),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ------------------ 1. GLASS NAVBAR ------------------
  PreferredSizeWidget _buildGlassAppBar(bool isDesktop) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 70),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.7),
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MSP.", // Initials logo
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
                if (isDesktop)
                  Row(
                    children: [
                      _navItem("Home"),
                      _navItem("Experience"),
                      _navItem("Skills"),
                      _navItem("Contact"),
                    ],
                  )
                else
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu, color: secondaryColor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: secondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ------------------ 2. HERO SECTION (Profile) ------------------
  Widget _buildHeroSection(double width, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          isDesktop ? 100 : 20, 120, isDesktop ? 100 : 20, 50),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side: Text
          Expanded(
            flex: isDesktop ? 6 : 0,
            child: Column(
              crossAxisAlignment: isDesktop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Flutter Developer",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ).animate().fadeIn().slideY(),
                const SizedBox(height: 20),
                Text(
                  "Mohammed\nShaheen PK",
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 60 : 36,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    color: secondaryColor,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(),
                const SizedBox(height: 20),
                Text(
                  "Building pixel-perfect, smooth mobile & web applications.\nSpecialized in GetX, Clean Architecture, and Interactive UI.",
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _downloadCV,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: Text("Download CV",
                      style: const TextStyle(color: Colors.white)),
                ).animate().scale(delay: 600.ms),
              ],
            ),
          ),
          // Right Side: Image
          if (isDesktop) const Spacer(flex: 1),
          Container(
            height: isDesktop ? 400 : 250,
            width: isDesktop ? 400 : 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 50,
                  spreadRadius: 10,
                )
              ],
              image: const DecorationImage(
                image: AssetImage('assets/profileweb.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 8),
            ),
          ).animate().fadeIn(duration: 800.ms).scale(),
        ],
      ),
    );
  }

  // ------------------ 3. EXPERIENCE GRID ------------------
  Widget _buildExperienceSection(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: isDesktop
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: _HoverCard(
                url: 'https://www.transwarranty.com',
                title: "Senior Flutter Developer",
                company: "Transwarranty Finance",
                date: "2023 - Present",
                desc:
                "Led development of 2 production apps using GetX, bloc, Dio. Managed complex state and real-time Firebase integration.",
                color: Colors.blueAccent,
              )),
          const SizedBox(width: 30),
          Expanded(
              child: _HoverCard(
                url: 'https://rootsysinternational.com/',
                title: "Junior Mobile Developer",
                company: "Rootsys International",
                date: "2021 - 2022",
                desc:
                "Built pixel-perfect UIs and integrated REST APIs. Focused on clean code and bug fixing.",
                color: Colors.teal,
              )),
        ],
      )
          : Column(
        children: [
          _HoverCard(
            url: 'https://www.transwarranty.com/',
            title: "Senior Flutter Developer",
            company: "Transwarranty Finance",
            date: "2023 - Present",
            desc: "Led development of 2 production apps using GetX.",
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          _HoverCard(
            url: 'https://rootsysinternational.com/',
            title: "Junior Mobile Developer",
            company: "Rootsys International",
            date: "2021 - 2022",
            desc: "Built pixel-perfect UIs and integrated REST APIs.",
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  // ------------------ 4. SKILLS ------------------
  Widget _buildSkillsSection(double width) {
    final skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'GetX',
      'Riverpod',
      'REST APIs',
      'Git',
      'UI/UX',
      'Bloc',
      'Clean Architecture'
    ];

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: width > 800 ? 150 : 20),
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: skills.map((skill) {
          return Chip(
            backgroundColor: Colors.white,
            elevation: 3,
            shadowColor: Colors.black12,
            surfaceTintColor: Colors.white,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            avatar: Icon(Icons.verified, color: primaryColor, size: 20),
            label: Text(
              skill,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ).animate().fadeIn().scale();
        }).toList(),
      ),
    );
  }

  // ------------------ 5. FOOTER ------------------
  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      width: double.infinity,
      color: secondaryColor,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Let's Work Together",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.email, "https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox?compose=CllgCKCCSPMZJwjrfBgHFtBzVhXdNSCkrsVMBSPZjRsMrDhfpdnpjHsqnHnrRqTwDRKJHpHfDFg"),
              const SizedBox(width: 20),
              _socialIcon(Icons.code, "https://github.com/shaheensha-007"),
              const SizedBox(width: 20),
              _socialIcon(Icons.link, "www.linkedin.com/in/mohammedshaheenpk"),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            "© 2025 Mohammed Shaheen PK. All rights reserved.",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      onPressed: ()async {
        final Uri uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
        await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // opens in browser
        );
        } else {
        debugPrint("Could not launch $url");
        }
      },
      icon: Icon(icon, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  // Helper: Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 3, width: 40, color: secondaryColor),
        ],
      ),
    );
  }
}

// ------------------ CUSTOM WIDGET: HOVER CARD ------------------
class _HoverCard extends StatefulWidget {
  final String title, company, date, desc;
  final Color color;
  final String url; // 👈 Add this

  const _HoverCard({
    required this.title,
    required this.company,
    required this.date,
    required this.desc,
    required this.color,
    required this.url, // 👈 Add this
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}
class _HoverCardState extends State<_HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () async {
          final Uri uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            debugPrint("Cannot launch ${widget.url}");
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(30),
          transform:
          Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered ? widget.color : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? widget.color.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
                blurRadius: isHovered ? 30 : 10,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: Icon(Icons.work, color: widget.color),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(widget.company,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Text(
                widget.date,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              const SizedBox(height: 15),
              Text(
                widget.desc,
                style: const TextStyle(height: 1.5, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
