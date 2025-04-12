
log(Message,Level) :-
    log_level(Level),
    map_log_level_color(Level, Color),
    write_color(Message, Color).

log(Message) :-
    default_log_level(Level),
    log(Message,Level).

        
write_color(Text, Color) :-
    color_code(Color, Code),
    format("\e[~wm~w\e[0m", [Code, Text]).
