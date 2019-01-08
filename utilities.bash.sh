#!/bin/bash

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# set up prompt & colors
function set_prompt {
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[0;32m\]"
  local CYAN="\[\033[0;36m\]"
  local GRAY="\[\033[0;37m\]"
  local BLUE="\[\033[0;34m\]"

  #export PS1="\u@\h \t ${CYAN}\`parse_git_branch\` ${GREEN}\n[${BLUE}\w${GREEN}][\$(kube_ps1)]$ "

	#if [ `tput cols` -gt 100 ]; then
    export PS1="$GREEN[\u - \d \t]-\033[0m(\$(cat $HOME/.config/gcloud/active_config))-\$(kube_ps1)$GREEN[$CYAN\`parse_git_branch\`${GREEN}]\n[${BLUE}\w${GREEN}]$ "
  #else
	#	export PS1="$GREEN[\u \t]\033[0m(\$(cat $HOME/.config/gcloud/active_config))\n${GREEN}[${BLUE}\w${GREEN}]$ "
  #fi
	export PS2="| => "
}

# Catchup a directory of repos all at once
function git_catchup {
  for d in */;
  do
    echo $d
    cd $d

    if [ $? -eq 0 ];
    then
      git fetch
      git pull

      if [ $? -ne 0 ];
      then
        git stash
        git pull
      fi
      cd ..
    fi
  done

}
