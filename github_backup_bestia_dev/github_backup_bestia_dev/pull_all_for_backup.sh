# /d/box_original_1/BestiaDev/github_backup_bestia_dev/github_backup_bestia_dev/pull_all_for_backup.sh
# formatted with v7.2.5 of https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format

# Run in git-bash. github.com does not have harsh limits on ssh connections like codeberg.org has.
# After the migration to codeberg.org, I have just a few repositories on github.com, so I don't need to complicate with parallelism.

cur_dir="/d/box_original_1/BestiaDev/github_backup_bestia_dev/github_backup_automation_tasks_rs"

# check if script is run in the right directory
if [ $PWD != "$cur_dir" ]; then
  printf "\033[0;31m Error: Not in the right directory! \033[0m\n"
  printf "\033[0;33m    Usage: \033[0m\n"
  printf "\033[0;32m cd $cur_dir \033[0m\n"
  printf "\033[0;32m sh pull_all_for_backup.sh \033[0m\n"
  exit 1
fi

printf " \n"
printf "\033[0;33m    Script to pull (fetch+merge) all the changes from GitHub into local folder \033[0m\n"
printf " $cur_dir \n"
printf "\033[0;33m    This makes a backup of the GitHub repo. This local folder is then synced automatically to Hetzner Storage Box. \033[0m\n"
printf " \n"

COUNTER=1
# Loop through hidden and not hidden directories is not trivial
# Warning: the hidden directory must begin with . but we must avoid . and .. special meaning relative directories

for folder in $(ls -d $cur_dir/.[!.]*/ $cur_dir/*/ 2>/dev/null); do

  cd $folder
  printf " $COUNTER. $folder \n"
  git fetch --all
  git merge
  printf "\n"

  COUNTER=$((COUNTER + 1))
done

cd $cur_dir/

printf "\033[0;33m    Num of repositories should be: 7 \033[0m\n"
printf " \n"
