import 'package:flutter/material.dart';

class DropdownSearchBar extends StatefulWidget {
  final List<String> categories;
  final Function(String category, String query) onSearch;

  const DropdownSearchBar({
    super.key,
    required this.categories,
    required this.onSearch,
  });

  @override
  State<DropdownSearchBar> createState() => _DropdownSearchBarState();
}

class _DropdownSearchBarState extends State<DropdownSearchBar> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.categories.first;
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    widget.onSearch(_selectedCategory, query);
    _focusNode.unfocus(); // 키보드 닫기
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dropdown
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
              items: widget.categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // SearchBar
        Expanded(
          child: SearchBar(
            controller: _searchController,
            focusNode: _focusNode,
            onSubmitted: (_) => _submitSearch(),
            hintText: '검색',
            trailing: [
              IconButton(
                iconSize: 18,
                padding: EdgeInsets.zero,
                icon: Icon(
                    Icons.search,
                  color: Colors.grey[500],
                ),
                onPressed: _submitSearch,
              ),
            ],
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8, vertical: 0), // 세로 패딩 최소화
            ),
            constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: 32),
            shape: WidgetStateProperty.all(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16))
            ),
            side: WidgetStateProperty.all(
              BorderSide(color: Colors.grey.shade400)
            ),
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ],
    );
  }
}
