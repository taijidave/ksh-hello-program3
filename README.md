# ksh-hello-program3

Rename ALL (mp3) files from ALL child dir's => names from listfile  -and- truncate filenames to &lt; 90 chars :-D

	rencdadir.ksh  =>> FOR HOLLYWOOD-EFFECTS FILE-LISTINGS!! <<== 
	rename ALL (mp3) files from ALL child dir's => names from listfile 
	-and- truncate filenames to < 90 chars :-D

	USE:
	./rencdadir.ksh {offset} {cdnamelist_prefix} {filename_extension} {W}
	{offset}: what's the diff between 1st dir, & the numbered dir
	   example:  0  first dir
	            40  41st dir

	{filename_extension}: .mp3, .shn, .flac, etc

	Example(s):
	...for bbc01 w/ *.mp3 files 	(read-only pass)
	   ./rencdadir.ksh 0 bbc .mp3

	...for l205 w/ *.shn files	(update the files)
	   ./rencdadir.ksh 4 l2 .shn W


	!!!!!! NOTE !!!!!!  !!!!!! NOTE !!!!!!  !!!!!! NOTE !!!!!!
	Prep Listfile: => fixcdnamelist.ksh
