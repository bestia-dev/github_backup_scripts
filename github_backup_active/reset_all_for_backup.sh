# /d/Dropbox/BestiaDev/github_backup_active/reset_all_for_backup.sh

cur_dir="/d/Dropbox/BestiaDev/github_backup_active"

# check if script is run in the right directory
if [ $PWD != "$cur_dir" ]; then
  printf "\033[0;31m Error: Not in the right directory! \033[0m\n"
  printf "\033[0;33m    Usage: \033[0m\n"
  printf "\033[0;32m cd $cur_dir \033[0m\n"
  printf "\033[0;32m sh reset_all_for_backup.sh \033[0m\n"
  exit 1;
fi

printf " \n"
printf "\033[0;33m    Script to reset and pull all the changes from GitHub to local folder \033[0m\n"
printf " $cur_dir \n"
printf "\033[0;33m    WARNING: all changed files in the local folder will be undone. \033[0m\n"
printf "\033[0;33m    Num of sub-folders: 3 \033[0m\n"
printf " \n"

COUNTER=1
# Loop through hidden and not hidden directories is not trivial
# Warning: the hidden directory must begin with . but we must avoid . and .. special meaning relative directories
# If the list is empty it returns an error that is than used as a folder name. Pipe the error messages away from the result.
for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2> /dev/null) ; do
    cd $folder
    printf " $COUNTER. subfolder"
    pwd
    COUNTER=$(expr $COUNTER + 1)

    sh reset_all_for_backup.sh
done

cd $cur_dir/
