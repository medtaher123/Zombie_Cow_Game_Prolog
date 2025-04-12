% --------------------  console config  --------------------

% log levels, comment out the ones you don't want
log_level(default).
log_level(info).
log_level(success).
log_level(warning).
log_level(alert).
log_level(question).


% colors: red, green, blue, yellow, cyan, magenta, white
map_log_level_color(default,white).
map_log_level_color(info,cyan).
map_log_level_color(success,green).
map_log_level_color(warning,yellow).
map_log_level_color(alert,red).
map_log_level_color(question,magenta).

default_log_level(default).

color_code(red, 31).
color_code(green, 32).
color_code(yellow, 33).
color_code(blue, 34).
color_code(magenta, 35).
color_code(cyan, 36).
color_code(white, 37).



% --------------------  game config  --------------------

largeur(10).
hauteur(10).

nombre_rochers(5).
nombre_arbres(5).
nombre_vaches(brune, 5).
nombre_vaches(simmental, 4).
nombre_vaches(alpine_herens, 3).

dimitri_char('D',green).

libre_char('.',white).
rocher_char('R',white).
arbre_char('A',white).
%vache_char(brune,vache,'B').
%vache_char(simmental,vache,'S').
%vache_char(alpine_herens,vache,'H').
vache_char(_,vache,'V',cyan).
vache_char(_,zombie,'Z',red).

input_map('z',nord).
input_map('s',sud).
input_map('q',ouest).
input_map('d',est).
input_map('a',reste).
