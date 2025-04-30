
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  

  const SearchInput({
    Key? key,
    this.hintText = "Search for pizza",
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
         onSubmitted: onChanged, 
        onChanged: (query) {
          print("User searched: $query"); 
          if (onChanged != null) {
            onChanged!(query);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0x000000).withOpacity(0.4),
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              controller.clear();
              if (onChanged != null) {
                onChanged!('');
              }
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFFFF1E6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
