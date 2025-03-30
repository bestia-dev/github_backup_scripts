# /d/Dropbox/BestiaDev/github_backup_active/github_backup_bestia_dev/push_all_for_backup.sh

cur_dir="/d/Dropbox/BestiaDev/github_backup_active/github_backup_bestia_dev"

# check if script is run in the right directory
if [ $PWD != "$cur_dir" ]; then
  printf "\033[0;31m Error: Not in the right directory! \033[0m\n"
  printf "\033[0;33m    Usage: \033[0m\n"
  printf "\033[0;32m cd $cur_dir \033[0m\n"
  printf "\033[0;32m sh push_all_for_backup.sh \"commit message\" \033[0m\n"
  exit 1;
fi

# mandatory argument "message"
if [ ! "$1" ]; then
  printf "\033[0;31m Error: The argument \"commit message\" must be provided ! \033[0m\n"
  printf "\033[0;33m    Usage: \033[0m\n"
  printf "\033[0;32m sh push_all_for_backup.sh \"commit message\" \033[0m\n"
  exit 1;
fi

printf "commit message: $1\n";

printf " \n"
printf "\033[0;33m    Script to add, commit and push the changes to GitHub from \033[0m\n"
printf " $cur_dir \n"
printf "\033[0;33m    This is used to make small changes to all the projects at once. \033[0m\n"
printf " \n"

COUNTER=1
# Loop through hidden and not hidden directories is not trivial
# Warning: the hidden directory must begin with . but we must avoid . and .. special meaning relative directories
# If the list is empty it returns an error that is than used as a folder name. Pipe the error messages away from the result.
for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2> /dev/null) ; do
    # parallelism with ()& confuses the output. I want to print correctly in sequence.
    (cd $folder
    printf " $COUNTER. $folder \n" &> "temp$COUNTER.txt" 
    printf "."
    git add . &>> "temp$COUNTER.txt"  
    git commit -a -m "$1" &>> "temp$COUNTER.txt"  
    git push &>> "temp$COUNTER.txt"  
    printf "."
    )&
    COUNTER=$((COUNTER+1))
done
wait
printf "\n"
cd $cur_dir/

COUNTER=1
for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2> /dev/null) ; do
    cd $folder
    cat "temp$COUNTER.txt"
    rm "temp$COUNTER.txt"
    COUNTER=$((COUNTER+1))
done

cd $cur_dir/
printf "\033[0;33m    Num of repositories should be: 57 \033[0m\n"
printf " \n"