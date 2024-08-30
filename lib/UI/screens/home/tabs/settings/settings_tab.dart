import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 25,
          child: Container(
            width: double.infinity,
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, top: 10),
              child: Text("Setting",
                  style: GoogleFonts.getFont("Poppins",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ),
        Expanded(
          flex: 75,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Language",
                    style: GoogleFonts.getFont("Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildLangDropdown(),
                ),
                const SizedBox(height: 15),
                Text("Mode",
                    style: GoogleFonts.getFont("Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildThemeDropdown(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  DropdownButton<String> buildLangDropdown() {
    return DropdownButton(items: [
      DropdownMenuItem<String>(
          value: "ar",
          child: Text(
            "Arabic",
            style: GoogleFonts.getFont(
              "Inter",
              fontSize: 14,
              color: const Color(0xFF5D9CEC),
            ),
          )),
      DropdownMenuItem<String>(
          value: "en",
          child: Text(
            "English",
            style: GoogleFonts.getFont(
              "Inter",
              fontSize: 14,
              color: const Color(0xFF5D9CEC),
            ),
          ))
    ], isExpanded: true, onChanged: (_) {});
  }

  DropdownButton<String> buildThemeDropdown() {
    return DropdownButton(items: [
      DropdownMenuItem<String>(
        value: "light",
        child: Text(
          "Light",
          style: GoogleFonts.getFont(
            "Inter",
            fontSize: 14,
            color: const Color(0xFF5D9CEC),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "dark",
        child: Text(
          "Dark",
          style: GoogleFonts.getFont(
            "Inter",
            fontSize: 14,
            color: const Color(0xFF5D9CEC),
          ),
        ),
      )
    ], isExpanded: true, onChanged: (_) {});
  }
}
