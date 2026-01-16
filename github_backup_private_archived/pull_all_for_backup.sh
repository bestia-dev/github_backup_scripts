# /d/Dropbox/BestiaDev/github_backup/github_backup_private_archived/pull_all_for_backup.sh

cur_dir="/d/Dropbox/BestiaDev/github_backup/github_backup_private_archived"

# check if script is run in the right directory
if [ $PWD != "$cur_dir" ]; then
  printf "\033[0;31m Error: Not in the right directory! \033[0m\n"
  printf "\033[0;33m    Usage: \033[0m\n"
  printf "\033[0;32m cd $cur_dir \033[0m\n"
  printf "\033[0;32m sh pull_all_for_backup.sh \033[0m\n"
  exit 1;
fi

printf " \n"
printf "\033[0;33m    Script to pull (fetch+merge) all the changes from GitHub into local folder \033[0m\n"
printf " $cur_dir \n"
printf "\033[0;33m    This makes a backup of the GitHub repo. This local folder is then synced automatically to DropBox. \033[0m\n"
printf " \n"

COUNTER=1
# Loop through hidden and not hidden directories is not trivial
# Warning: the hidden directory must begin with . but we must avoid . and .. special meaning relative directories
# If the list is empty it returns an error that is than used as a folder name. Pipe the error messages away from the result.
for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2> /dev/null) ; do
    # parallelism with ()& confuses the output. I want to print correctly in sequence.
    (cd $folder
    mkdir -p tmp
    printf " $COUNTER. $folder \n" &> "tmp/temp$COUNTER.txt" 
    printf "."
    git fetch --all &>> "tmp/temp$COUNTER.txt"  
    git merge &>> "tmp/temp$COUNTER.txt" 
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
    cat "tmp/temp$COUNTER.txt"
    rm "tmp/temp$COUNTER.txt"
    COUNTER=$((COUNTER+1))  
done

cd $cur_dir/

printf "\033[0;33m    Num of repositories should be: 4 \033[0m\n"
printf " \n"
