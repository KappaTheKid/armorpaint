package arm.ui;

import haxe.io.Bytes;
import zui.Zui;
import zui.Id;
import arm.sys.Path;
import arm.io.ImportAsset;
using StringTools;

class TabConsole {

	@:access(zui.Zui)
	public static function draw() {
		var ui = UITrait.inst.ui;

		var title = Log.messageTimer > 0 ? Log.message + "        " : "Console";
		var color = Log.messageTimer > 0 ? Log.messageColor : -1;

		if (ui.tab(UITrait.inst.statustab, title, false, color) && UITrait.inst.statush > UITrait.defaultStatusH * ui.SCALE()) {

			ui.row([1 / 20, 1 / 20]);

			if (ui.button("Clear")) {
				Log.lastTraces = [];
			}
			if (ui.button("Export")) {
				var str = Log.lastTraces.join("\n");
				UIFiles.show("txt", true, function(path: String) {
					var f = UIFiles.filename;
					if (f == "") f = "untitled";
					path = path + "/" + f;
					if (!path.endsWith(".txt")) path += ".txt";
					Krom.fileSaveBytes(path, Bytes.ofString(str).getData());
				});
			}

			for (t in Log.lastTraces) {
				ui.text(t);
			}
		}
	}
}
