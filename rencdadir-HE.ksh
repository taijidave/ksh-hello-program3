#!/bin/ksh

#	10:39 AM 3/20/2009

#	rencdadir.ksh  =>> FOR HOLLYWOOD-EFFECTS FILE-LISTINGS!! <<== 
#	rename ALL (mp3) files from ALL child dir's => names from listfile 
#	-and- truncate filenames to < 90 chars :-D

#	USE:
#	./rencdadir.ksh {offset} {cdnamelist_prefix} {filename_extension} {W}
#	{offset}: what's the diff between 1st dir, & the numbered dir
#	   example:  0  first dir
#	            40  41st dir

#	{filename_extension}: .mp3, .shn, .flac, etc

#	Example(s):
#	...for bbc01 w/ *.mp3 files 	(read-only pass)
#	   ./rencdadir.ksh 0 bbc .mp3

#	...for l205 w/ *.shn files	(update the files)
#	   ./rencdadir.ksh 4 l2 .shn W


#	!!!!!! NOTE !!!!!!  !!!!!! NOTE !!!!!!  !!!!!! NOTE !!!!!!
#	Prep Listfile: => fixcdnamelist.ksh


# capture list of dir's -- PROBABLY DO THIS SEPARATELY, & EDIT dirlist!
ls -F | grep "/" | sed 's#/##' > ./dirlist

# get the number of files...
dirreps=`wc -l ./dirlist | awk '{print $1}'`


d=0				# initialize loop-var
x=$1				# offset 


# parse dir list
while test $d -lt $dirreps
do

let "d=$d+1"
let "x=$x+1"

dirname=`awk -F: 'NR == '$d' {print $1}' ./dirlist`
cd "$dirname"

#echo
echo $dirname
#pwd

# exit if first run (ie, generating 'dirlist'
#exit


if [ $x -lt 10 ]
then
	string=`echo $2"0"`
else
	string=`echo $2`
fi

cat ../cdnamelist | grep "$string$x" > ./locallist


if [ -f ./cachemv_* ]
then rm ./cachemv_*
fi

# capture a list of all filezs in this dir
ls *$3 > ./cachemv_$$

# get the number of files...
reps=`wc -l ./cachemv_$$ | awk '{print $1}'`


i=0				# initialize loop-var

# parse dir list
while test $i -lt $reps
do

let "i=$i+1"

   # pull all fields except the first 3.... we can do the filename-prefix later
   filenameZ=`awk 'NR == '$i' { for (f=1; f <= NF; f++) { if (f != 1 && f != 2 && f != 3) printf("%s ", $f);} printf("\n");}' ./locallist`

   if [ $i -lt 10 ]
   then
	filename2=`echo "0"$i"-"$filenameZ`
   else
	filename2=`echo $i"-"$filenameZ`
   fi

   # gotta do string func's using files... THANKS MKS! :-/
   echo $filename2 > tmpfile
   testlen=`wc -m ./tmpfile | awk '{print $1}'`		# <-- character-count, including 'space's

   if [ $testlen -gt "90" ]
   then
      filename2=`head -c 90 tmpfile`			# pull the first 90 chars, including 'space's
   fi

   filename3=`echo $filename2"$3"`
   filename4=`echo $filename3 | sed 's/ \./\./'`


   filename1=`awk -F: 'NR == '$i' {print $1}' ./cachemv_$$`


   # rename the files
   if [ $4 ] 
   then
     if [ $4 == 'W' ]
	then mv ./"$filename1" ./"$filename4"
	else echo "$filename1" ' => ' "$filename4"
     fi
   else echo "$filename1" ' => ' "$filename4"
   fi


   done

   rm ./cachemv_*
   rm ./locallist
   rm tmpfile


cd ..

done


#rm ./dirlist
#rm ./cdnamelist

