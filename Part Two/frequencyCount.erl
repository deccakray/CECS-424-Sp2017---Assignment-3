-module(frequencyCount).
-export([returnListFromFile/1, returnListOfTuples/2, buildHashTable/1, returnFinalHashTable/1]).

returnListFromFile(FileName) ->
	%% Read file
	{ok, Device} = file:open(FileName, [read]),
	%% Save read lines into Line1
	Line1 = io:get_line(Device, ''),
	%% delimeter for creating words
	List = string:tokens(Line1, ",.\n _: 0123456789"),
	List.


returnListOfTuples(Word, ListOfTuples) ->
	%% condition that takes in Word, index, and list of tuples
	case lists:keyfind(Word, 1, ListOfTuples) of
		%% if pattern match, replace tuple with new tuple ++Value
		{Word, Value} -> lists:keyreplace(Word, 1, ListOfTuples, {Word, Value + 1});
		%% if no match, append a new tuple to ListOfTuples
		false -> [{Word, 1}|ListOfTuples]
	end.

buildHashTable(ListofWords) ->
	%% builds hash table using foldl: takes 3 arguments -- 
	%% 1st argument is a function that takes in two arguments
	%% 2nd argument is the initial value of the accumulator (empty)
	%% 3rd argument is the list being iterated on
	lists:foldl(fun(Word, ListOfTuples) -> returnListOfTuples(string:to_lower(Word), ListOfTuples) end, [], ListofWords).

returnFinalHashTable(FileName) ->
	%% This function sorts the hashtable generated in the previous function
	L_Words = returnListFromFile(FileName),
	L_Tuples = buildHashTable(L_Words),
	io:fwrite("~p~n", [lists:reverse(lists:keysort(2, L_Tuples))]).