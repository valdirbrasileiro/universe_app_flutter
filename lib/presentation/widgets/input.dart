import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? hintText;
  final TextEditingController inputController;

  const Input({super.key, this.hintText, required this.inputController});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Future<void> _cleanInput() async {
    if (widget.inputController.text.isNotEmpty) {
      widget.inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: widget.inputController,
        decoration: InputDecoration(
            hintText: widget.hintText ?? 'Digite aqui...',
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: ValueListenableBuilder(
                valueListenable: widget.inputController,
                builder: (_, __, ___) => widget.inputController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: _cleanInput,
                        child: IconTheme(
                          data: IconTheme.of(context),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      )
                    : const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.deepPurpleAccent,
                          ),)),
      ),
    );
  }
}
