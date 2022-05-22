import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final bool? enabled;
  final bool? hideLeft;
  final SearchBarType? searchBarType;
  final String? hint;
  final String? defaultText;
  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? speakClick;
  final void Function()? inputBoxClick;
  final ValueChanged<String>? onChanged;

  const SearchBar(
      {Key? key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: widget.hideLeft ?? false
                    ? null
                    : const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leftButtonClick ?? () {}),
          Expanded(flex: 1, child: _inputBox()),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: const Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick ?? () {})
        ],
      ),
    );
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: [
                    Text('上海',
                        style:
                            TextStyle(color: _homeFontColor(), fontSize: 14)),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor(),
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick ?? () {}),
          Expanded(flex: 1, child: _inputBox()),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ),
              widget.rightButtonClick ?? () {})
        ],
      ),
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? const Color(0xffA9A9A9)
                : Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.fromLTRB(0, 8.5, 0, 8.5),
                          contentPadding: const EdgeInsets.all(0),
                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: widget.hint ?? '',
                          hintStyle: const TextStyle(fontSize: 15)),
                    )
                  : _wrapTap(
                      Container(
                        child: Text(
                          widget.defaultText ?? '',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick ?? () {})),
          showClear
              ? _wrapTap(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
              : _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick ?? () {})
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: child,
    );
  }

  _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
