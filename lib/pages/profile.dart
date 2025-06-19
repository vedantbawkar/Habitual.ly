import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_friends.dart';

class ProfilePage extends StatelessWidget {
  final int coins;
  final int streak;
  final List<String> friends;

  const ProfilePage({
    Key? key,
    required this.coins,
    required this.streak,
    required this.friends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF8B4513)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B4513),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Avatar and Name
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECE3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 60,
                      color: Color(0xFFFF8C42),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "John Doe",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Stats Section
            Text(
              "Your Stats",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8B4513),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                // Coins Stats
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFD700).withOpacity(0.2),
                          Color(0xFFFFA500).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Color(0xFFFFD700),
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Coins",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFF8B4513).withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "$coins",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Streak Stats
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF4500).withOpacity(0.2),
                          Color(0xFFFF6B35).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFFF4500),
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Streak",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFF8B4513).withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "$streak",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Friends Section
            Text(
              "Your Friends",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8B4513),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "No friends added yet",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Color(0xFF8B4513).withOpacity(0.6),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFriendsPage()),
                    );
                  },
                  child: Text(
                    "Make new friends!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xFFFF8C42),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}