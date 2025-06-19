import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/habit.dart';

// class HabitTile extends StatelessWidget {
//   final Habit habit;
//   final ValueChanged<bool?> onChanged;

//   HabitTile({required this.habit, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       title: Text(
//         habit.title,
//         style: TextStyle(
//           decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       value: habit.isCompleted,
//       onChanged: onChanged,
//     );
//   }
// }

class ImprovedHabitTile extends StatelessWidget {
  final Habit habit;
  final Function(bool?) onChanged;

  const ImprovedHabitTile({
    Key? key,
    required this.habit,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              habit.isCompleted
                  ? [Color(0xFFE8F5E8), Color(0xFFF0F8F0)]
                  : [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              habit.isCompleted
                  ? Color(0xFF4CAF50).withOpacity(0.2)
                  : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color:
                habit.isCompleted
                    ? Color(0xFF4CAF50).withOpacity(0.1)
                    : Color(0xFFD2691E).withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient:
                  habit.isCompleted
                      ? LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                      )
                      : LinearGradient(
                        colors: [Colors.white, Color(0xFFFFF8F0)],
                      ),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    habit.isCompleted
                        ? Color(0xFF4CAF50)
                        : Color(0xFFD2691E).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Checkbox(
              value: habit.isCompleted,
              onChanged: onChanged,
              activeColor: Colors.transparent,
              checkColor: Colors.white,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              habit.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    habit.isCompleted ? Color(0xFF4CAF50) : Color(0xFF8B4513),
                decoration:
                    habit.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
              ),
            ),
          ),
          if (habit.isCompleted)
            Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
        ],
      ),
    );
  }
}
