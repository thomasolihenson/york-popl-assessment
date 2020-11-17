%%%% Question 1 - List of predicates of each station and which lines it is part of

% Bakerloo Line Stations
station('EC',['bakerloo']).                      % Elephant & Castle
station('EM',['bakerloo','northern']).           % Embankment
station('OC',['bakerloo','central','victoria']). % Oxford Circus
station('PA',['bakerloo']).                      % Paddington
station('WA',['bakerloo']).                      % Warwick Avenue
% Central Line Stations
station('BG',['central']).                       % Bethnal Green
station('CL',['central']).                       % Chancery Lane
station('LG',['central']).                       % Lancaster Gate
station('LS',['central','metropolitan']).        % Liverpool Street
station('NH',['central']).                       % Notting Hill Gate
station('TC',['central','northern']).            % Tottenham Court Road
% Metropolitan Line Stations
station('AL',['metropolitan']).                  % Aldgate
station('BS',['metropolitan']).                  % Baker Street
station('FR',['metropolitan']).                  % Finchley Road
station('KX',['metropolitan','victoria']).       % Kings Cross
% Northern Line Stations
station('EU',['northern']).                      % Euston
station('KE',['northern']).                      % Kennington
station('WS',['northern','victoria']).           % Warren Street
% Victoria Line Stations
station('BR',['victoria']).                      % Brixton
station('FP',['victoria']).                      % Finsbury Park
station('VI',['victoria']).                      % Victoria

%%%% Question 2 - A predicate that that checks whether a station exists

% station_exists() : Checks that there exists a definition for Station and
%                    ignores any value for the list of lines by using 'None'

station_exists(Station):-
    station(Station,_None).

% Test Case 1 :
%   station_exists('BR').
% returns :
%   true.

% Test Case 2 :
%   station_exists(X).
% returns :
%   X = 'EC' ;
%   X = 'EM' ;
%   X = 'OC' ;
%   X = 'PA' ;
%   X = 'WA' ;
%   X = 'BG' ;
%   X = 'CL' ;
%   X = 'LG' ;
%   X = 'LS' ;
%   X = 'NH' ;
%   X = 'TC' ;
%   X = 'AL' ;
%   X = 'BS' ;
%   X = 'FR' ;
%   X = 'KX' ;
%   X = 'EU' ;
%   X = 'KE' ;
%   X = 'WS' ;
%   X = 'BR' ;
%   X = 'FP' ;
%   X = 'VI'.

% Test Case 3 :
%   station_exists('ZZ').
% returns :
%   false.

% Test Case 4 :
%   station_exists(5).
% returns :
%   false.

%%%% Question 3 - A list of predicates defining which stations are adjacent to each other

% Bakerloo Line
isadjacent('EC','EM'). % Elephant & Castle / Embankment
isadjacent('EM','KE'). % Embankment / Kennington
isadjacent('EM','OC'). % Embankment / Oxford Circus
isadjacent('EM','TC'). % Embankment / Tottenham Court Road
isadjacent('OC','LG'). % Oxford Circus / Lancaster Gate
isadjacent('OC','PA'). % Oxford Circus / Paddington
isadjacent('OC','TC'). % Oxford Circus / Tottenham Court Road
isadjacent('OC','VI'). % Oxford Circus / Victoria
isadjacent('OC','WS'). % Oxford Circus / Warren Street
isadjacent('PA','WA'). % Paddington / Warwick Avenue
% Central Line
isadjacent('BG','LS'). % Bethnal Green / Liverpool Street
isadjacent('LS','AL'). % Liverpool Street / Aldgate
isadjacent('LS','CL'). % Liverpool Street / Chancery Lane
isadjacent('LS','KX'). % Liverpool Street / Kings Cross
isadjacent('CL','TC'). % Chancery Lane / Tottenham Court Road
isadjacent('TC','WS'). % Tottenham Court Road / Warren Street
isadjacent('LG','NH'). % Lancaster Gate / Notting Hill Gate
% Metropolitan Line
isadjacent('AL','LS'). % Aldgate / Liverpool Street
isadjacent('KX','BS'). % Kings Cross / Baker Street
isadjacent('KX','FP'). % Kings Cross / Finsbury Park
isadjacent('KX','WS'). % Kings Cross / Warren Street
isadjacent('BS','FR'). % Baker Street / Finchley Road
% Northern Line
isadjacent('EU','WS'). % Euston / Warren Street
% Victoria Line
isadjacent('BR','VI'). % Brixton / Victoria

% adjacent() : Checks if Station1 and Station2 are explicitly adjacent, i.e. if
%              they are defined within 'isadjacent()' and checks whether they
%              are defined as the reverse. Returns true if either is true

adjacent(Station1,Station2):-
    isadjacent(Station1,Station2);
    isadjacent(Station2,Station1).

% Test Case 1 :
%   adjacent('EC','EM').
% returns :
%   true.

% Test Case 2 :
%   adjacent('EM','EC').
% returns :
%   true.

% Test Case 3 :
%   adjacent('EC',X).
% returns :
%   X = 'EM' ;
%   false.

% Test Case 4 :
%   adjacent(5,6).
% returns :
%   false.

%%%% Question 4 - A predicate that checks whether two stations are on the same line and what line they share

% sameline(): Gets the list of lines at Station 1 and Station 2, then returns
%             true if there is a member in common between the two lists of lines

sameline(Station1,Station2,Line):-
    station(Station1,Station1Line),
    station(Station2,Station2Line),
    member(Line,Station1Line),
    member(Line,Station2Line).

% Test Case 1 :
%   sameline('EC','OC','bakerloo').
% returns :
%   true ;
%   false.

% Test Case 2 :
%   sameline('EC','OC','victoria').
% returns :
%   false.

% Test Case 3 :
%   sameline('EC','EC','bakerloo').
% returns :
%   true.

% Test Case 4 :
%   sameline('A','B','bakerloo').
% returns :
%   false.

%%%% Question 5 - Predicate to list all stations on a given line

% station_on_line() : Gets the list of lines at the given Station, then returns
%                     true if the given Line is a member of the list of lines

station_on_line(Station,Line):-
    station(Station,ListofLines),
    member(Line,ListofLines).

% line() : Calls the 'station_on_line' predicate for all Station values for a
%          single given Line

line(Line,ListOfStations):-
    findall(Station,station_on_line(Station,Line),ListOfStations).

% Test Case 1 :
%   line('bakerloo',X).
% returns :
%   X = ['EC', 'EM', 'OC', 'PA', 'WA'].

% Test Case 2 :
%   line('BG',X).
% returns :
%   X = [].

% Test Case 3 :
%   line('Victoria',X).
% returns :
%   X = [].

% Test Case 4 :
%   line(line,X).
% returns :
%   X = [].

%%%% Question 6 - Predicate for the number of lines that run through a station

% station_numlines() : Finds the list of lines at the given Station, then uses
%                      'length()' to return the length of the list, therefore
%                      the number of lines

station_numlines(Station,NumberOfLines):-
    station(Station,Line),
    length(Line,NumberOfLines).

% Test Case 1 :
%   station_numlines('BG',X).
% returns :
%   X = 1.

% Test Case 2 :
%   station_numlines('OC',X).
% returns :
%   X = 3.

% Test Case 3 :
%   station_numlines('station',X).
% returns :
%   false.

% Test Case 4 :
%   station_numlines(Station,2).
% returns :
%   Station = 'EM' ;
%   Station = 'LS' ;
%   Station = 'TC' ;
%   Station = 'KX' ;
%   Station = 'WS' ;
%   false.

%%%% Question 7 - Predicate to list which stations are adjacent to an interchange station

% adjacent2interchange() : Finds the number of lines at NonInterStation and
%                          checks that this is equal to 1, then finds the number
%                          of lines at InterchangeStation and checks that this
%                          is greater than 1. If so, it calls adjacent() to
%                          checks that the two stations are adjacent

adjacent2interchange(NonInterStation,InterchangeStation):-
    station_numlines(NonInterStation,NonInterStationNumLines),
    NonInterStationNumLines == 1,
    station_numlines(InterchangeStation,InterchangeStationNumLines),
    InterchangeStationNumLines > 1,
    adjacent(NonInterStation,InterchangeStation).

% Test Case 1 :
%   adjacent2interchange('LG','OC').
% returns :
%   true.

% Test Case 2 :
%   adjacent2interchange('OC','LG').
% returns :
%   false.

% Test Case 3 :
%   adjacent2interchange('WS','WS').
% returns :
%   false.

% Test Case 4 :
%   adjacent2interchange('NH','OC').
% returns :
%   false.

%%%% Question 8 - Predicate to give a route between two stations

% route_main() : The main recursive case, finds a station adjacent to From and
%                checks that this is not To. Then checks that From is not a member
%                of TempRoute. Calls route_main() again with From appended to
%                the start of TempRoute

route_main(From,To,TempRoute,Route):-
    adjacent(From,Next),
    not(Next = To),
    not(member(From, TempRoute)),
    route_main(Next,To,[From|TempRoute],Route).

% route_main() : Base recursive case, if From and To are adjacent, and From is
%                not a member of TempRoute, Route set to From appended to the
%                start of TempRoute

route_main(From,To,TempRoute,Route):-
    adjacent(From,To),
    not(member(From,TempRoute)),
    Route = [From|TempRoute].

% route() : Calls the main route funtion route_main() with an empty route, then
%           returns the reversed route recived with the destination To appended

route(From,To,Route):-
    route_main(From, To, [], RouteReturn),
    reverse([To|RouteReturn],Route).

% Test Case 1 :
%   route('OC','TC',Route).
% returns :
%   Route = ['OC', 'TC'] ;
%   Route = ['OC', 'WS', 'TC'] ;
%   Route = ['OC', 'WS', 'KX', 'LS', 'CL', 'TC'] ;
%   Route = ['OC', 'EM', 'TC'] ;
%   false.

% Test Case 1 :
%   route('OC','TC',Route).
% returns :
%   Route = ['OC', 'TC'] ;
%   Route = ['OC', 'WS', 'TC'] ;
%   Route = ['OC', 'WS', 'KX', 'LS', 'CL', 'TC'] ;
%   Route = ['OC', 'EM', 'TC'] ;
%   false.

%%%% Question 9 - Predicate to find the time taken to travel between two stations (assuming travel between two stations is 4 minutes)

% route_time() : This uses the previous 'route()' predicate to get the list of
%                stations on the route, then takes the number of stations minus
%                one, i.e. the number of transitions, and multiplies it by 4

route_time(From,To,Route,Minutes):-
    route(From,To,Route),
    length(Route,Time),
    Minutes is (Time-1)*4.

% Test Case 1 :
%   route_time('OC','TC',Route,Minutes).
% returns :
%   Route = ['OC', 'TC'],
%   Minutes = 4 ;
%   Route = ['OC', 'WS', 'TC'],
%   Minutes = 8 ;
%   Route = ['OC', 'WS', 'KX', 'LS', 'CL', 'TC'],
%   Minutes = 20 ;
%   Route = ['OC', 'EM', 'TC'],
%   Minutes = 8 ;
%   false.

% Test Case 2 :
%   route_time('NH','LG',['NH','LG'],Minutes).
% returns :
%   Minutes = 4 ;
%   false.

% Test Case 3 :
%   route_time('OC',To,Route,4).
% returns :
%   To = 'LG',
%   Route = ['OC', 'LG'] ;
%   To = 'PA',
%   Route = ['OC', 'PA'] ;
%   To = 'TC',
%   Route = ['OC', 'TC'] ;
%   To = 'VI',
%   Route = ['OC', 'VI'] ;
%   To = 'WS',
%   Route = ['OC', 'WS'] ;
%   To = 'EM',
%   Route = ['OC', 'EM'] ;
%   false.

% Test Case 4 :
%   route_time(From,To,Route,3).
% returns :
%   false.