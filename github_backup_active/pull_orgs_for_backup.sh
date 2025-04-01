# /d/Dropbox/BestiaDev/github_backup_active/pull_all_for_backup.sh

cur_dir="/d/Dropbox/BestiaDev/github_backup_active"

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
printf "\033[0;33m    Num of sub-folders: 5 \033[0m\n"
printf " \n"

COUNTER=1
# Loop through hidden and not hidden directories is not trivial
# Warning: the hidden directory must begin with . but we must avoid . and .. special meaning relative directories
# If the list is empty it returns an error that is than used as a folder name. Pipe the error messages away from the result.
for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2> /dev/null) ; do
    cd $folder
    printf "\n"
    printf " $COUNTER. subfolder "
    pwd
    COUNTER=$((COUNTER+1))  

    sh pull_all_for_backup.sh
done

printf "\033[0;33m    Num of sub-folders: 5 \033[0m\n"
printf " \n"
cd $cur_dir/
