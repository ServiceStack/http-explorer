import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:httpexplorer/models/app.dart';
import 'package:httpexplorer/models/site.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, app, child) {
      return Column(
          children: app.sites.map((site) => SiteItem(site)).toList());
    });
  }
}

class SiteItem extends StatefulWidget {
  final Site site;
  SiteItem(this.site);

  @override
  State<StatefulWidget> createState() => _SiteItemState();
}

class _SiteItemState extends State<SiteItem> {
  @override
  Widget build(BuildContext context) {
    var site = widget.site;
    return InkWell(
      onTap: () { setState(() => site.toggleExpanded()); },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SiteNode(
          key: ValueKey(widget.site.baseUrl),
          site: widget.site
        ),
      ),
    );
  }
}

class SiteNode extends StatelessWidget {
  final Site site;
  final GestureTapCallback? onTap;

  const SiteNode({Key? key, required this.site, this.onTap}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var title = site.friendlyLabel;
    Widget txt = Text(title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 16));
    if (title.length > 25) {
      txt = Tooltip(
          message: title,
          child: txt);
    }
    return Row(
      children: [
        site.expanded
            ? const Icon(Icons.keyboard_arrow_down, size: 20)
            : const Icon(Icons.keyboard_arrow_right, size: 20),
        Expanded(child: txt),
        if (site.expanded)
          ...site.routes.map((e) => Text(e.path))
      ],
    );
  }
}

class SiteTreeView extends StatelessWidget {
  final Site site;

  SiteTreeView(this.site, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}