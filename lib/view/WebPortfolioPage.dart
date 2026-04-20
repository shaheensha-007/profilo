// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:ui';
//
// class WebPortfolioPage extends StatefulWidget {
//   const WebPortfolioPage({super.key});
//
//   @override
//   State<WebPortfolioPage> createState() => _WebPortfolioPageState();
// }
//
// class _WebPortfolioPageState extends State<WebPortfolioPage> {
//   final ScrollController _scrollController = ScrollController();
//
//   // Keys for Section Navigation
//   final GlobalKey _homeKey = GlobalKey();
//   final GlobalKey _experienceKey = GlobalKey();
//   final GlobalKey _skillsKey = GlobalKey();
//   final GlobalKey _footerKey = GlobalKey();
//   final GlobalKey _projectsKey = GlobalKey();
//
//   // Color Palette
//   final Color primaryColor = const Color(0xFF2563EB);
//   final Color secondaryColor = const Color(0xFF1E293B);
//   final Color bgColor = const Color(0xFFF8FAFC);
//
//   // Scroll Logic
//   void _scrollToSection(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(
//         context,
//         duration: const Duration(milliseconds: 800),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   void _downloadCV() async {
//     final Uri url = Uri.parse('https://drive.google.com/file/d/1Y7x4-GeCuKRsrlSwrslf_1jVaL15y3gf/view?usp=drive_link');
//     if (!await launchUrl(url)) {
//       debugPrint('Could not launch $url');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     bool isDesktop = width > 900;
//
//     return Scaffold(
//       backgroundColor: bgColor,
//       extendBodyBehindAppBar: true,
//       appBar: _buildGlassAppBar(isDesktop),
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           children: [
//             // HERO SECTION
//             Container(key: _homeKey, child: _buildHeroSection(width, isDesktop)),
//             const SizedBox(height: 80),
//             // EXPERIENCE SECTION
//             _buildSectionTitle("Experience"),
//             Container(key: _experienceKey, child: _buildExperienceSection(isDesktop)),
//             const SizedBox(height: 80),
//             _buildSectionTitle("Featured Projects"),
//             Container(key: _projectsKey, child: _buildProjectsSection(width, isDesktop)),
//             const SizedBox(height: 80),
//             // TECH STACK SECTION
//             _buildSectionTitle("Tech Stack"),
//             Container(key: _skillsKey, child: _buildSkillsSection(width)),
//             const SizedBox(height: 100),
//             // FOOTER / CONTACT
//             Container(key: _footerKey, child: _buildFooter()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ------------------ 1. GLASS NAVBAR ------------------
//   PreferredSizeWidget _buildGlassAppBar(bool isDesktop) {
//     return PreferredSize(
//       preferredSize: const Size(double.infinity, 70),
//       child: ClipRRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             color: Colors.white.withOpacity(0.7),
//             padding: EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "MSP.",
//                   style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900,
//                     color: primaryColor,
//                   ),
//                 ),
//                 if (isDesktop)
//                   Row(
//                     children: [
//                       _navItem("Home", _homeKey),
//                       _navItem("Experience", _experienceKey),
//                       _navItem("Skills", _skillsKey),
//                       _navItem("Projects", _projectsKey),
//                       _navItem("Contact", _footerKey),
//
//                     ],
//                   )
//                 else
//                   IconButton(
//                       onPressed: () => _scrollToSection(_footerKey),
//                       icon: Icon(Icons.menu, color: secondaryColor))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _navItem(String title, GlobalKey sectionKey) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: TextButton(
//         style: TextButton.styleFrom(
//           foregroundColor: secondaryColor,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         onPressed: () => _scrollToSection(sectionKey),
//         child: Text(
//           title,
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   // ------------------ 2. HERO SECTION ------------------
//   Widget _buildHeroSection(double width, bool isDesktop) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(isDesktop ? 100 : 20, 150, isDesktop ? 100 : 20, 50),
//       child: Flex(
//         direction: isDesktop ? Axis.horizontal : Axis.vertical,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: isDesktop ? 6 : 0,
//             child: Column(
//               crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text("Flutter Developer", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
//                 ).animate().fadeIn().slideY(),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Mohammed\nShaheen PK",
//                   textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//                   style: GoogleFonts.poppins(
//                     fontSize: isDesktop ? 60 : 36,
//                     fontWeight: FontWeight.w900,
//                     height: 1.1,
//                     color: secondaryColor,
//                   ),
//                 ).animate().fadeIn(delay: 200.ms).slideX(),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Building pixel-perfect, smooth mobile & web applications.\nSpecialized in GetX, Clean Architecture, and Interactive UI.",
//                   textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//                   style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600], height: 1.5),
//                 ).animate().fadeIn(delay: 400.ms),
//                 const SizedBox(height: 40),
//                 ElevatedButton.icon(
//                   onPressed: _downloadCV,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   icon: const Icon(Icons.download, color: Colors.white),
//                   label: const Text("Download CV", style: TextStyle(color: Colors.white)),
//                 ).animate().scale(delay: 600.ms),
//               ],
//             ),
//           ),
//           if (isDesktop) const SizedBox(width: 50),
//           Container(
//             height: isDesktop ? 350 : 250,
//             width: isDesktop ? 350 : 250,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 50)],
//               image: const DecorationImage(image: AssetImage('assets/profileweb.jpg'), fit: BoxFit.cover),
//               border: Border.all(color: Colors.white, width: 8),
//             ),
//           ).animate().fadeIn(duration: 800.ms).scale(),
//         ],
//       ),
//     );
//   }
//
//   // ------------------ 3. EXPERIENCE SECTION ------------------
//   Widget _buildExperienceSection(bool isDesktop) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
//       child: isDesktop
//           ? Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: _buildTranswarrantyCard()),
//           const SizedBox(width: 30),
//           Expanded(child: _buildRootsysCard()),
//         ],
//       )
//           : Column(
//         children: [
//           _buildTranswarrantyCard(),
//           const SizedBox(height: 20),
//           _buildRootsysCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTranswarrantyCard() {
//     return const _HoverCard(
//       title: "Mobile Application Developer (Flutter)",
//       company: "Transwarranty Finance",
//       location: "Kochi, India",
//       date: "July 2023 - Present",
//       desc: "Developed an agent-based mobile application for a financial services company. Enabled features for customers to apply for loans. Focused on improving agent-customer experience. Built high-performance interface using Flutter.",
//       color: Colors.blueAccent,
//     );
//   }
//
//   Widget _buildRootsysCard() {
//     return const _HoverCard(
//       title: "Mobile Application Developer (Flutter)",
//       company: "Rootsys International",
//       location: "Malappuram, India",
//       date: "March 2022 - June 2023",
//       desc: "Gained hands-on experience in real-world software projects. Worked with Flutter and Python. Collaborated on innovative software solutions and gained exposure to MERN stack.",
//       color: Colors.orangeAccent,
//     );
//   }
//
//   // ------------------ 4. SKILLS SECTION ------------------
//   Widget _buildSkillsSection(double width) {
//     final skills = ['Flutter', 'Dart', 'Firebase', 'GetX', 'Riverpod', 'REST APIs', 'Git', 'UI/UX', 'Bloc', 'Clean Architecture'];
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: width > 800 ? 150 : 20),
//       child: Wrap(
//         spacing: 15, runSpacing: 15, alignment: WrapAlignment.center,
//         children: skills.map((skill) => Chip(
//           backgroundColor: Colors.white,
//           label: Text(skill, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
//           avatar: Icon(Icons.verified, color: primaryColor, size: 18),
//         ).animate().fadeIn().scale()).toList(),
//       ),
//     );
//   }
//
//   // ------------------ 5. FOOTER ------------------
//   Widget _buildFooter() {
//     return Container(
//       margin: const EdgeInsets.only(top: 80),
//       width: double.infinity,
//       color: secondaryColor,
//       padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
//       child: Column(
//         children: [
//           Text("Let's Work Together", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _socialIcon(Icons.email, "mailto:your-email@gmail.com"),
//               const SizedBox(width: 20),
//               _socialIcon(Icons.code, "https://github.com/shaheensha-007"),
//               const SizedBox(width: 20),
//               _socialIcon(Icons.link, "https://linkedin.com/in/mohammedshaheenpk"),
//             ],
//           ),
//           const SizedBox(height: 30),
//           const Text("© 2026 Mohammed Shaheen PK. All rights reserved.", style: TextStyle(color: Colors.white54, fontSize: 12)),
//         ],
//       ),
//     );
//   }
//
//   Widget _socialIcon(IconData icon, String url) {
//     return IconButton(
//       onPressed: () async => await launchUrl(Uri.parse(url)),
//       icon: Icon(icon, color: Colors.white),
//       style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1)),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 50),
//       child: Column(
//         children: [
//           Text(title.toUpperCase(), style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2, color: primaryColor)),
//           const SizedBox(height: 10),
//           Container(height: 3, width: 40, color: secondaryColor),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProjectsSection(double width, bool isDesktop) {
//     // 1. Keep the data list here
//     final List<Map<String, String>> projects = [
//       {
//         "title": "Oroboro assisted app",
//         "desc": "Oroboro_assisted_App is a comprehensive banking application designed to manage various banking functionalities, focusing on loan-related services. The application provides a seamless user experience for customers to apply for loans, track loan status, and manage repayments, along with other essential banking operations.",
//         "tech": "Flutter • Firebase • Bloc . REST API ",
//         "link": "https://github.com/shaheensha-007/oroboro_assisted_app",
//       },
//       {
//         "title": "E-Commerce UI Kit",
//         "desc": "A pixel-perfect shopping app UI with smooth animations.",
//         "tech": "Flutter • Riverpod • Clean Architecture",
//         "link": "https://github.com/shaheensha-007",
//       },
//       // Add more projects here...
//     ];
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: projects.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: isDesktop ? 3 : 1,
//           crossAxisSpacing: 25,
//           mainAxisSpacing: 25,
//           mainAxisExtent: 300,
//         ),
//         itemBuilder: (context, index) {
//           // 2. Pass both the project data AND the index
//           return _buildProjectCard(projects[index], index);
//         },
//       ),
//     );
//   }
//
// // 3. Update the parameters to accept (Map project, int index)
//   Widget _buildProjectCard(Map<String, String> project, int index) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.folder_open_outlined, color: primaryColor, size: 40),
//           const SizedBox(height: 20),
//           Text(project['title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           Text(project['desc']!, style: TextStyle(color: Colors.grey[600], height: 1.5)),
//           const Spacer(),
//           Text(project['tech']!, style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 15),
//           InkWell(
//             onTap: () => launchUrl(Uri.parse(project['link']!)),
//             child: const Row(
//               children: [
//                 Text("View Project", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Icon(Icons.arrow_right_alt, size: 20),
//               ],
//             ),
//           )
//         ],
//       ),
//     ).animate().fadeIn(delay: (200 * index).ms).slideY(begin: 0.2); // Now uses 'index' directly
//   }
//
//
//
//
//
// }
//
// // ------------------ HOVER CARD WIDGET ------------------
// class _HoverCard extends StatefulWidget {
//   final String title, company, date, desc, location;
//   final Color color;
//
//   const _HoverCard({
//     required this.title, required this.company, required this.date,
//     required this.desc, required this.location, required this.color,
//   });
//
//   @override
//   State<_HoverCard> createState() => _HoverCardState();
// }
//
// class _HoverCardState extends State<_HoverCard> {
//   bool isHovered = false;
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> points = widget.desc.split('.').where((p) => p.trim().isNotEmpty).toList();
//
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: isHovered ? widget.color : Colors.transparent, width: 2),
//           boxShadow: [BoxShadow(color: isHovered ? widget.color.withOpacity(0.1) : Colors.black12, blurRadius: 10)],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             Text("${widget.company} • ${widget.location}", style: TextStyle(color: widget.color, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 12),
//             AnimatedSize(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               child: isExpanded
//                   ? Column(
//                 children: points.map((p) => Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("• ", style: TextStyle(color: widget.color, fontWeight: FontWeight.bold)),
//                       Expanded(child: Text(p.trim(), style: const TextStyle(height: 1.5))),
//                     ],
//                   ),
//                 )).toList(),
//               )
//                   : Text(widget.desc, maxLines: 2, overflow: TextOverflow.ellipsis),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () => setState(() => isExpanded = !isExpanded),
//                 child: Text(isExpanded ? "View Less" : "View More"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

import 'Main_pages/chatbot/chat_button.dart';
import 'package:shaprofile/view/pdf_viewer_screen.dart';

class WebPortfolioPage extends StatefulWidget {
  const WebPortfolioPage({super.key});

  @override
  State<WebPortfolioPage> createState() => _WebPortfolioPageState();
}

class _WebPortfolioPageState extends State<WebPortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();

  final Color primaryColor = const Color(0xFF2563EB);
  final Color secondaryColor = const Color(0xFF1E293B);
  final Color bgColor = const Color(0xFFF8FAFC);

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _downloadCV() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PdfViewerScreen(assetPath: 'assets/mohammed_shaheen_pk.pdf'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;

    return Scaffold(
      floatingActionButton: ChatBotButton(),
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildGlassAppBar(isDesktop),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              key: _homeKey,
              child: _buildHeroSection(width, isDesktop),
            ),
            const SizedBox(height: 80),
            _buildSectionTitle("Experience"),
            Container(
              key: _experienceKey,
              child: _buildExperienceSection(isDesktop),
            ),
            const SizedBox(height: 80),
            _buildSectionTitle("Featured Projects"),
            Container(
              key: _projectsKey,
              child: _buildProjectsSection(width, isDesktop),
            ),
            const SizedBox(height: 80),
            _buildSectionTitle("Tech Stack"),
            Container(key: _skillsKey, child: _buildSkillsSection(width)),
            const SizedBox(height: 100),
            Container(key: _footerKey, child: _buildFooter()),
          ],
        ),
      ),
    );
  }

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
                  "MSP.",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
                if (isDesktop)
                  Row(
                    children: [
                      _navItem("Home", _homeKey),
                      _navItem("Experience", _experienceKey),
                      _navItem("Projects", _projectsKey),
                      _navItem("Skills", _skillsKey),
                      _navItem("Contact", _footerKey),
                    ],
                  )
                else
                  IconButton(
                    onPressed: () => _scrollToSection(_footerKey),
                    icon: Icon(Icons.menu, color: secondaryColor),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, GlobalKey sectionKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: secondaryColor),
        onPressed: () => _scrollToSection(sectionKey),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildHeroSection(double width, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 100 : 20,
        150,
        isDesktop ? 100 : 20,
        50,
      ),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: isDesktop ? 6 : 0,
            child: Column(
              crossAxisAlignment: isDesktop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Flutter Developer",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: _downloadCV,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    "Download CV",
                    style: TextStyle(color: Colors.white),
                  ),
                ).animate().scale(delay: 600.ms),
              ],
            ),
          ),
          if (isDesktop) const SizedBox(width: 50),
          Container(
            height: isDesktop ? 350 : 250,
            width: isDesktop ? 350 : 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 50),
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

  Widget _buildExperienceSection(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTranswarrantyCard()),
                const SizedBox(width: 30),
                Expanded(child: _buildRootsysCard()),
              ],
            )
          : Column(
              children: [
                _buildTranswarrantyCard(),
                const SizedBox(height: 20),
                _buildRootsysCard(),
              ],
            ),
    );
  }

  Widget _buildTranswarrantyCard() => const _HoverCard(
    title: "Mobile Application Developer (Flutter)",
    company: "Transwarranty Finance",
    location: "Kochi, India",
    date: "July 2023 - Present",
    desc:
        "Developed an agent-based mobile application for a financial services company. Enabled features for customers to apply for loans. Focused on improving agent-customer experience. Built high-performance interface using Flutter.",
    color: Colors.blueAccent,
  );
  Widget _buildRootsysCard() => const _HoverCard(
    title: "Mobile Application Developer (Flutter)",
    company: "Rootsys International",
    location: "Malappuram, India",
    date: "March 2022 - June 2023",
    desc:
        "Gained hands-on experience in real-world software projects. Worked with Flutter and Python. Collaborated on innovative software solutions and gained exposure to MERN stack.",
    color: Colors.orangeAccent,
  );

  Widget _buildProjectsSection(double width, bool isDesktop) {
    final List<Map<String, String>> projects = [
      {
        "title": "Oroboro assisted app",
        "desc":
            "Oroboro_assisted_App is a comprehensive banking application designed to manage various banking functionalities, focusing on loan-related services. The application provides a seamless user experience for customers to apply for loans, track loan status, and manage repayments, along with other essential banking operations.",
        "tech": "Flutter • Firebase • Bloc • REST API",
        "link": "https://github.com/shaheensha-007/oroboro_assisted_app",
      },
      {
        "title": "Vertex broking",
        "desc":
            "Vertex Broking App is an all-in-one stock market and investment platform offering real-time market data for stocks, F&O, and mutual funds. The app provides community insights, detailed market reports with view and download options, and live trading features including open and close trades. Users can open a Demat account in minutes directly within the app, making investing simple, fast, and secure",
        "tech": "Flutter • Get-x  • Clean Architecture • Firebase ",
        "link": "https://github.com/shaheensha-007",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 25,
            runSpacing: 25,
            children: projects.asMap().entries.map((entry) {
              return SizedBox(
                width: isDesktop
                    ? (constraints.maxWidth - 50) / 3
                    : constraints.maxWidth,
                child: _ProjectCard(
                  project: entry.value,
                  index: entry.key,
                  primaryColor: primaryColor,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

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
      'Clean Architecture',
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width > 800 ? 150 : 20),
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: skills
            .map(
              (skill) => Chip(
                backgroundColor: Colors.white,
                label: Text(
                  skill,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                avatar: Icon(Icons.verified, color: primaryColor, size: 18),
              ).animate().fadeIn().scale(),
            )
            .toList(),
      ),
    );
  }

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
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.email, "mailto:your-email@gmail.com"),
              const SizedBox(width: 20),
              _socialIcon(Icons.code, "https://github.com/shaheensha-007"),
              const SizedBox(width: 20),
              _socialIcon(
                Icons.link,
                "https://linkedin.com/in/mohammedshaheenpk",
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "© 2026 Mohammed Shaheen PK. All rights reserved.",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) => IconButton(
    onPressed: () async => await launchUrl(Uri.parse(url)),
    icon: Icon(icon, color: Colors.white),
    style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1)),
  );

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

// ------------------ PROJECT CARD WIDGET ------------------
class _ProjectCard extends StatefulWidget {
  final Map<String, String> project;
  final int index;
  final Color primaryColor;

  const _ProjectCard({
    required this.project,
    required this.index,
    required this.primaryColor,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_outlined,
            color: widget.primaryColor,
            size: 40,
          ),
          const SizedBox(height: 20),
          Text(
            widget.project['title']!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(
              widget.project['desc']!,
              maxLines: isExpanded ? 20 : 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600], height: 1.5),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              isExpanded ? "View Less" : "View More",
              style: TextStyle(
                color: widget.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.project['tech']!,
            style: TextStyle(
              color: widget.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => launchUrl(Uri.parse(widget.project['link']!)),
            child: const Row(
              children: [
                Text(
                  "View Project",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_right_alt, size: 20),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (200 * widget.index).ms).slideY(begin: 0.2);
  }
}

// ------------------ EXPERIENCE HOVER CARD ------------------
class _HoverCard extends StatefulWidget {
  final String title, company, date, desc, location;
  final Color color;
  const _HoverCard({
    required this.title,
    required this.company,
    required this.date,
    required this.desc,
    required this.location,
    required this.color,
  });
  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool isHovered = false;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final List<String> points = widget.desc
        .split('.')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered ? widget.color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered ? widget.color.withOpacity(0.1) : Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.company} • ${widget.location}",
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: isExpanded
                  ? Column(
                      children: points
                          .map(
                            (p) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      color: widget.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      p.trim(),
                                      style: const TextStyle(height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Text(
                      widget.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setState(() => isExpanded = !isExpanded),
                child: Text(isExpanded ? "View Less" : "View More"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
