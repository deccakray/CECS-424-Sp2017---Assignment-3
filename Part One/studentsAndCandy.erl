-module(studentsAndCandy).
-export([adjustCandy/4, oddCheck/1, main/0, printCandy/4]).

%% Function for whistle blowing. . . adjusts candy for students
adjustCandy(S1, S2, S3, Turn) when S1 =/= S2; S1 =/= S3; S2 =/= S3 -> 

	printCandy(S1, S2, S3, Turn),

	%% get halves of each student's amount
	HalfOfS1 = S1 div 2,
	HalfOfS2 = S2 div 2,
	HalfOfS3 = S3 div 2,

	%% form new amount for each student by receiving half from student on the left
	POST_S2 = HalfOfS1 + HalfOfS2,
	POST_S3 = HalfOfS2 + HalfOfS3,
	POST_S1 = HalfOfS1 + HalfOfS3,

	%% increment turn
	TURNS = Turn + 1,

	%% odd check
	oddCheck(POST_S1),
	oddCheck(POST_S2),
	oddCheck(POST_S3),
 	
 	%% recursively call adjustCandy
 	adjustCandy(POST_S1, POST_S2, POST_S3, TURNS);

 adjustCandy(S1, S2, S3, TURN) when S1 =:= S2, S2 =:= S3 ->
 	printCandy(S1, S2, S3, TURN),
 	io:format("DONE. Every kid has equal amount of candy.~n").

%% get random number of candy
getRandomCandyAmount() ->
	rand:uniform(10)*2.

printCandy(S1, S2, S3, TURNS) -> 
  io:format("\tTurn: ~B~n*****Blow whistle*****~nstudent1: ~B~nstudent2: ~B~nstudent3: ~B~n~n", [TURNS, S1, S2, S3]).

%% checks if amount of candy is odd
oddCheck(Candy) ->
	if 
		Candy rem 2 =:= 1 ->
			Candy + 1;
		true ->
			Candy
	end.
	
main() ->
	TURNS = 1,
	adjustCandy(getRandomCandyAmount(),getRandomCandyAmount(), getRandomCandyAmount(), TURNS).