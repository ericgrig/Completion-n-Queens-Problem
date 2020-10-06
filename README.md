# Completion-n-Queens-Problem

   n-Queens Completion Problem-Linear Algorithm-Source Code

The source code (Matlab) of the linear algorithm of solving the n-Queens Completion Problem, is presented with detailed comments:

   Solution_n_Queens_Completion_Problem.m
	
Two more programs are also presented:

   Generation_k_Queens_Composition.m,
	
- the program for generating an arbitrary composition of k queens that is not contradictory located on a chessboard of size n x n;

   Validation_n_Queens_Problem_Solution.m
	
- program for checking the correctness of solution the n-Queens Problem, as well as checking the absence of contradiction in composition of k queens on chessboard.

A list of the most important questions on the structure of the algorithm and detailed answers to them is given:

Questions & Answers . To the project -- Linear algorithm for solution n-Queens Completion problem.txt
	
An example of using the presented program is given.

An example of using the program_Solution n-Queens Completion Problem_to complete compositions.txt
	
Additional information on this project is also provided:

Read_me_First.txt
	
In addition to the programs with commentary in English, each of the three programs is also
presented with commentary in two more languages: French and Russian. This means that along
with the above three files, there are three more similar files with comments in French and
the corresponding three files with comments in Russian. At the end of the name of these files
are added: _Comments_in_France or _Comments_in_Russian.

For ease of reading, all information materials (including programs source code) were prepared
in MS Word and presented in .docx format. This allowed all information to be presented in
a more readable form. All these materials are presented in three catalogs, depending on the
description language: in_English, en_Francais, in_Russian. To familiarize yourself with this
material, you need to go to the appropriate directory and download the required file from
GitHub to your computer.
 
If necessary, you can copy the .m format  executable file with comments,
and paste into the Matlab editor window. The program will work fine.

Comments in the program are enough detailed and, in a sense, redundant.
However, I am sure that this will provide an opportunity for the great number
of programmers to understand the essence of the algorithm, and, if desired,
translate it into another programming language.

Verification of the presented algorithm is simplified as much as possible:

1. Necessary to run the program for generating an arbitrary composition

	   Generation_k_Queens_Composition.m,
	   ----------------------------------

specifying the size n of the chessboard in it. This will create a random,
not contradictory composition, consisting of k queens.

2. After that it is necessary to start the program 

	   Solution_n_Queens_Completion_Problem.m,
	   ---------------------------------------
	
for  completing the composition. A decision will be received.

3. To check the correctness of the solution, it is necessary to run the program

	   Validation_n_Queens_Problem_Solution.m
	   --------------------------------------

By default, the filenames in all three programs are mutually agreed.
If you specify a different name, it is necessary to match the names of the respective programs.

All programs run very fast. Generation an arbitrary composition on the chessboard
with size 1000x1000, completing this composition and checking the correctness
of the obtained solution take no more than 0.1 seconds.


   EricGrig,   Marseille,   October,  2020
  
  
