# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/neven/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/neven/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/neven/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/neven/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/neven/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/neven/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# check additional arguments to script
if [[ $1 == "ros1" ]]; then
	echo "ROS1"
	cd ~/new_catkin_ws/src/mrover
	mamba activate ros_env
	source ~/new_catkin_ws/devel/setup.zsh
else
	echo "ROS2"
	cd ~/ros2_ws/src/mrover
	mamba activate ros2_env
	readonly CATKIN_WORKSPACE_PATH=~/ros2_ws
	#source /opt/
	readonly CATKIN_SETUP_PATH=${CATKIN_WORKSPACE_PATH}/install/setup.zsh
	export XDG_SESSION_TYPE=x11
	export ROS_DOMAIN_ID=5
	if [ -f ${CATKIN_SETUP_PATH} ]; then
		source ${CATKIN_SETUP_PATH}
	fi
	# for autocomplete
	eval "$(register-python-argcomplete ros2)"
	eval "$(register-python-argcomplete colcon)"
fi
#alias clang++-18="clang++"
