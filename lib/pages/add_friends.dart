import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Friend {
  final String username;
  final int streak;

  Friend({required this.username, required this.streak});
}

class AddFriendsPage extends StatefulWidget {
  @override
  _AddFriendsPageState createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  // List of potential friends
  final List<String> dummyUsers = [
    "john_doe",
    "fitness_lover",
    "habit_master",
    "daily_achiever",
    "wellness_guru",
  ];

  // List of added friends
  List<Friend> myFriends = [];
  List<String> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    filteredUsers = List.from(dummyUsers);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers =
          dummyUsers
              .where(
                (user) =>
                    user.toLowerCase().contains(query.toLowerCase()) &&
                    !myFriends.any((friend) => friend.username == user),
              )
              .toList();
    });
  }

  void _addFriend(String username) {
    if (!myFriends.any((friend) => friend.username == username)) {
      setState(() {
        // Add friend with a random streak (1-30 for demo purposes)
        myFriends.add(
          Friend(
            username: username,
            streak: (1 + DateTime.now().millisecondsSinceEpoch % 30),
          ),
        );
        // Update filtered users
        _filterUsers(_searchController.text);
      });
    }
  }

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
          "Friends",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B4513),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFFFF8C42),
          unselectedLabelColor: Color(0xFF8B4513).withOpacity(0.5),
          indicatorColor: Color(0xFFFF8C42),
          tabs: [Tab(text: "Add Friends"), Tab(text: "My Friends")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Add Friends Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8B4513).withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterUsers,
                    style: GoogleFonts.poppins(color: Color(0xFF8B4513)),
                    decoration: InputDecoration(
                      hintText: "Search by username",
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF8B4513).withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8B4513).withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final username = filteredUsers[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF8B4513).withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFFFECE3),
                          child: Text(
                            username[0].toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: Color(0xFFFF8C42),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Text(
                          username,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF8B4513),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: () => _addFriend(username),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFFFECE3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Add Friend",
                            style: GoogleFonts.poppins(
                              color: Color(0xFFFF8C42),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ), // My Friends Tab
          myFriends.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 64,
                      color: Color(0xFF8B4513).withOpacity(0.3),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No friends added yet",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Color(0xFF8B4513).withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Add friends to see their streaks",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF8B4513).withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: myFriends.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final friend = myFriends[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8B4513).withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFFFECE3),
                        child: Text(
                          friend.username[0].toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFF8C42),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                        friend.username,
                        style: GoogleFonts.poppins(
                          color: Color(0xFF8B4513),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF4500).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Color(0xFFFF4500),
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${friend.streak}",
                              style: GoogleFonts.poppins(
                                color: Color(0xFFFF4500),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
