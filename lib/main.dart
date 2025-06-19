import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/habit.dart';
import 'widgets/habit_tile.dart';
import 'widgets/progress_indicator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:habitually/pages/add_friends.dart';
// import 'pages/profile.dart';
import 'package:habitually/pages/profile.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => HabitTrackerApp(),
  ),
);

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitual.ly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HabitHomePage(),
    );
  }
}

class HabitHomePage extends StatefulWidget {
  @override
  _HabitHomePageState createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  final List<Habit> habits = [
    Habit(title: "Drink 2 liters of water"),
    Habit(title: "Exercise for 30 minutes"),
    Habit(title: "Cycling"),
  ];

  final TextEditingController habitController = TextEditingController();

  int _streak = 0;
  DateTime? _lastCompletionDate;
  int _coins = 0;
  int _todayCoinsEarned = 0;
  DateTime? _lastCoinDate;

  void addHabit() {
    String newHabit = habitController.text.trim();
    if (newHabit.isNotEmpty) {
      setState(() {
        habits.add(Habit(title: newHabit));
        habitController.clear();
      });
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _updateCoins(int completedTaskCount) {
    final today = DateTime.now();

    // Reset daily coins if it's a new day
    if (_lastCoinDate == null || !_isSameDay(_lastCoinDate!, today)) {
      _todayCoinsEarned = 0;
      _lastCoinDate = today;
    }

    // Calculate coins to add (5 per task, max 25 per day)
    int coinsToAdd = completedTaskCount * 5;
    int availableCoinsToday = 25 - _todayCoinsEarned;
    coinsToAdd = coinsToAdd.clamp(0, availableCoinsToday);

    if (coinsToAdd > 0) {
      setState(() {
        _coins += coinsToAdd;
        _todayCoinsEarned += coinsToAdd;
        _lastCoinDate = today;
      });
    }
  }

  void _updateStreakOnClear() {
    final today = DateTime.now();
    if (_lastCompletionDate == null ||
        !_isSameDay(_lastCompletionDate!, today)) {
      setState(() {
        _streak++;
        _lastCompletionDate = today;
      });
    }
  }

  void toggleCompletion(int index) {
    setState(() {
      habits[index].isCompleted = !habits[index].isCompleted;
    });
  }

  void clearCompleted() {
    final completedTasks = habits.where((habit) => habit.isCompleted).length;
    if (completedTasks > 0) {
      _updateCoins(completedTasks);
      _updateStreakOnClear();
      setState(() {
        habits.removeWhere((habit) => habit.isCompleted);
      });
    }
  }

  int get completedCount => habits.where((h) => h.isCompleted).length;

  void _showTipsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.90),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD2691E).withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tips for Success",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B4513),
                  ),
                ),
                SizedBox(height: 20),
                ...[
                      "🎯 Stay on track and watch your progress grow.",
                      "🔥 Don't break the chain – keep your daily streak alive!",
                      "🏆 Turn small wins into big rewards with H-Coins.",
                      "🌱 Build positive habits that last a lifetime.",
                      "💡 The more consistent you are, the more you earn!",
                      "⏳ Missed a day? Bounce back and keep moving forward.",
                    ]
                    .map(
                      (tip) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tip,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  height: 1.4,
                                  color: Color(0xFF8B4513).withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color(0xFFFF8C42).withOpacity(0.1),
                  ),
                  child: Text(
                    "Got it!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF8C42),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF8F0), Color(0xFFFEF4E8), Color(0xFFFDF0E5)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 48,
              left: 20.0,
              right: 20.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header and Counters
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Habitual.ly",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8B4513),
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Form habits, stay consistent",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xFF8B4513).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Counters Row
                      Row(
                        children: [
                          // Add Friend Button (Left aligned)
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8B4513).withOpacity(0.1),
                                  Color(0xFF8B4513).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.person_rounded,
                                color: Color(0xFF8B4513),
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProfilePage(
                                          coins: _coins,
                                          streak: _streak,
                                          friends:
                                              [], // Empty list for now as we haven't implemented friend storage yet
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8B4513).withOpacity(0.1),
                                  Color(0xFF8B4513).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.group_rounded,
                                color: Color(0xFF8B4513),
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFriendsPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(), // This will push the following items to the right
                          // Coins Counter
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFD700).withOpacity(0.9),
                                  Color(0xFFFFA500).withOpacity(0.9),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFFD700).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "$_coins",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Streak Counter
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFF4500).withOpacity(0.9),
                                  Color(0xFFFF6B35).withOpacity(0.9),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFF4500).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "$_streak",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tips Button
                          IconButton(
                            icon: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color(0xFFFFD700),
                                    Color(0xFFFFA500),
                                  ],
                                ).createShader(bounds);
                              },
                              child: Icon(Icons.star_rounded, size: 32),
                            ),
                            onPressed: () => _showTipsDialog(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Progress Section
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.white.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD2691E).withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomProgressIndicator(
                    total: habits.length,
                    completed: completedCount,
                  ),
                ),

                // Add Habit Section
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD2691E).withOpacity(0.08),
                        blurRadius: 16,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: habitController,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFF8B4513),
                          ),
                          decoration: InputDecoration(
                            hintText: "Add New Habit for the Day",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF8B4513).withOpacity(0.5),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: (_) => addHabit(),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFF8C42), Color(0xFFFF6B35)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF8C42).withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.white, size: 20),
                          onPressed: addHabit,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                // Habits List
                Expanded(
                  child:
                      habits.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.track_changes_outlined,
                                  size: 64,
                                  color: Color(0xFF8B4513).withOpacity(0.3),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "No habits added yet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Color(0xFF8B4513).withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Start building your daily routine",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xFF8B4513).withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            itemCount: habits.length,
                            itemBuilder:
                                (context, index) => Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: ImprovedHabitTile(
                                    habit: habits[index],
                                    onChanged: (_) => toggleCompletion(index),
                                  ),
                                ),
                          ),
                ), // Clear Button
                if (completedCount > 0)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF8C42).withOpacity(0.8),
                          Color(0xFFFF6B35).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFF8C42).withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: clearCompleted,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Clear Completed",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Habit Tile Widget
