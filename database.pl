:- discontiguous category_properties/2.
:- discontiguous object_properties/2.

% category_properties(category_name, list_of_properties)
category_properties(comedy, [emotional,funny]).
category_properties(drama, [emotional]).
category_properties(documentary, [nonfiction,informative]).

% object_properties(object_name, list_of_properties)
object_properties(crocodile_dundee,[comedy,australian,paul_hogan_movie]).
object_properties(flipper,[action_movie,australian,paul_hogan_movie,-comedy]).
object_properties(jackass,[comedy,-australian]).
object_properties(the_godfather,[drama,crime,-character_batman]).
object_properties(the_dark_knight,[drama,crime,character_batman]).
object_properties(the_living_planet, [documentary,director_attenborough]).
object_properties(the_code, [documentary,nerds_love_it]).
object_properties(the_russian_revolution, [documentary,about_history]).