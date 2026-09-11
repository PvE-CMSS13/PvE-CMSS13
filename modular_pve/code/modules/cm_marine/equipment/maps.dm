/obj/item/map/blackstone_bridge
	name = "\improper Blackstone Bridge map"
	desc = "A labeled blueprint of USCM Outpost 29. This outpost was specifically created to oversee travel and trade along the Blackstone Bridge, the only reliable means of traversing through the nearby mountain range."
	html_link = "https://i.postimg.cc/mRCKvNxG/Blackstone-Brdige-Blueprint-Game-Resize.png"
	color = "#1177b0"
	var/html_override = TRUE

//this sucks
/obj/item/map/blackstone_bridge/initialize_map()
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl || html_override)
		dat = {"
				<!DOCTYPE html>
				<html>
				<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta charset="utf-8">
					<style>
						img {
							display: none;
							position: absolute;
							top: 30;
							left: 0;
							max-width: 100%;
							height: auto;
							overflow: hidden;
							border: 0;
						}
					</style>
				</head>
				<body>
				<script type="text/javascript">
					function pageloaded(obj) {
						document.getElementById("loading").style.display = "none";
						obj.style.display = "inline";
					}
				</script>
				<p id='loading'>You start unfolding the map...</p>
					<img onload="pageloaded(this)" src="[html_override ? html_link : "[wikiurl]/[html_link]"]?printable=yes&remove_links=1" id="main_frame" alt=""></img>
				</body>

				</html>
			"}
	show_browser(usr, dat, name, "papermap", width = 1280, height = 720)
