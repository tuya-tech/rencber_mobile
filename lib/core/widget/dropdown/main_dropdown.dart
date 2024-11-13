import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropDownSearchField extends StatefulWidget {
  const DropDownSearchField(
      {super.key,
      required this.items,
      required this.controller,
      required this.itemBuilder,
      this.textFormFieldvalidator,
      this.textFormFieldDecoration,
      this.onSelected,
      this.textFormFieldstyle,
      this.onTap,
      this.menuHeight,
      this.onChanged,
      this.menuBgColor,
      this.errorWidget,
      this.menuDecoration,
      this.textFormscrollPadding});
  final TextEditingController controller;
  final String? Function(String?)? textFormFieldvalidator;
  final InputDecoration? textFormFieldDecoration;
  final List<String?> items;
  final Widget Function(BuildContext, String) itemBuilder;
  final void Function(String)? onSelected;
  final TextStyle? textFormFieldstyle;
  final void Function()? onTap;
  final double? menuHeight;
  final void Function(String)? onChanged;
  final Color? menuBgColor;
  final Widget? errorWidget;
  final BoxDecoration? menuDecoration;
  final EdgeInsets? textFormscrollPadding;

  @override
  State<DropDownSearchField> createState() => _DropDownSearchFieldState();
}

class _DropDownSearchFieldState extends State<DropDownSearchField> {
  List<String?> _items = [];
  List<String?> _filteredItems = [];
  bool _isTapped = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void filterItems(String searchText) {
    setState(() {
      _isLoading = true;
    });
    if (_isTapped && (_items.isEmpty || !listEquals(_items, widget.items.where((item) => item != null).toList()))) _items = widget.items.where((item) => item != null).toList();
    setState(() {
      if (searchText.isEmpty) {
        _filteredItems = _items;
      } else {
        _filteredItems = _items.where((element) => element!.toLowerCase().contains(searchText.toLowerCase())).toList();
      }
      _isLoading = false;
      _updateOverlay();
    });
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _toggleDropdown() {
    if (_isTapped) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      _isTapped = !_isTapped;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (_isTapped) _toggleDropdown();
            },
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 3),
            child: SizedBox(
              width: size.width,
              child: Material(
                child: Container(
                  decoration: widget.menuDecoration ?? BoxDecoration(color: widget.menuBgColor ?? Colors.white),
                  child: LayoutBuilder(
                    builder: (context, constraints) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: widget.menuHeight ?? 200,
                        minWidth: constraints.maxWidth,
                      ),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _filteredItems.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _filteredItems.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final item = _filteredItems[index];
                                    return InkWell(
                                      onTap: () {
                                        _toggleDropdown();
                                        widget.onSelected!(item);
                                      },
                                      child: widget.itemBuilder(context, item!),
                                    );
                                  },
                                )
                              : widget.errorWidget ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        scrollPadding: widget.textFormscrollPadding ?? const EdgeInsets.all(0),
        controller: widget.controller,
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
          _toggleDropdown();
          setState(() {
            filterItems(widget.controller.text);
          });
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        style: widget.textFormFieldstyle,
        validator: widget.textFormFieldvalidator,
        decoration: widget.textFormFieldDecoration ??
            InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Search",
              suffixIcon: const Icon(Icons.search),
            ),
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged!(value);
          setState(() {
            //if (_filteredItems.isEmpty) filterItems(value);
            filterItems(value);
          });
        },
      ),
    );
  }
}
