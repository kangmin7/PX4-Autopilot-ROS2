# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sb='source ~/.bashrc'
alias gb='gedit ~/.bashrc'
alias cb='cp ~/.bashrc ~/PX4-Autopilot'

alias ga='git add . && git commit -m'

alias memo='gedit ~/PX4-Autopilot/memo'
alias todo='gedit ~/todo'

alias TURTLE='roslaunch turtlebot3_gazebo turtlebot3_world.launch'
alias SLAM='roslaunch turtlebot3_slam turtlebot3_slam.launch slam_methods:=gmapping'
alias NAVIGATION='roslaunch turtlebot3_navigation turtlebot3_navigation.launch'
alias EXPLORE='roslaunch explore_lite explore.launch'

#alias tftree='rosrun rqt_tf_tree rqt_tf_tree'
alias tftree='cd ~/tftree && ros2 run tf2_tools view_frames && xdg-open $(ls -t frames_*.pdf | head -1)'
alias base_footprint_to_base_link='rosrun tf static_transform_publisher 0 0 0 0 0 0 base_footprint base_link 100'

# alias kill='pkill -9 px4 && pkill -9 gazebo && pkill -9 gzserver && pkill -9 gzclient && pkill gazebo && pkill gzserver && pkill gzclient'
#alias killgz='pkill -9 gz-sim && pkill -9 ign-gazebo && pkill -9 ign && pkill -9 -f "gz sim" && rm -rf ~/.ignition/gazebo'

killgz() {
    #pkill -9 gz-sim
    #pkill -9 ign-gazebo
    #pkill -9 ign
    pkill -9 -f "gz"
    pkill -9 -f "px4"
    rm -rf ~/.ignition/gazebo
}

alias killgz2='pkill gzclient'
alias checkgz='ps -ef | grep gz'
alias checkpx4='ps -ef | grep px4'
# alias kill='pkill px4 && pkill gazebo && pkill gzserver && pkill gzclient'
#alias px4_basic='cd ~/PX4-Autopilot && \
#DONT_RUN=1 make px4_sitl_default gazebo-classic && \
#source Tools/simulation/gazebo-classic/setup_gazebo.bash $(pwd) $(pwd)/build/px4_sitl_default && \
#export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(pwd):$(pwd)/Tools/simulation/gazebo-classic/sitl_gazebo-classic && \
#roslaunch px4 mavros_posix_sitl.launch'
#alias px4='cd ~/PX4-Autopilot && \
#DONT_RUN=1 make px4_sitl_default gazebo-classic && \
#source Tools/simulation/gazebo-classic/setup_gazebo.bash $(pwd) $(pwd)/build/px4_sitl_default && \
#export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(pwd):$(pwd)/Tools/simulation/gazebo-classic/sitl_gazebo-classic && \
#roslaunch px4 mavros_posix_sitl.launch vehicle:=iris_rplidar world:=$(rospack find mavlink_sitl_gazebo)/worlds/test_zone.world'
alias px4_basic='cd ~/PX4-Autopilot && make px4_sitl gz_x500_lidar_2d'
#alias px4='cd ~/PX4-Autopilot && make px4_sitl gz_x500_lidar_2d PX4_GZ_WORLD=husarion_office_empty'
alias px4='cd ~/PX4-Autopilot && make px4_sitl gz_x500_lidar_2d PX4_GZ_WORLD=walls'
alias dds='MicroXRCEAgent udp4 -p 8888'

alias ftc='cd ~/PX4-Autopilot_FTC && \
DONT_RUN=1 make px4_sitl_default gazebo-classic && \
source Tools/simulation/gazebo-classic/setup_gazebo.bash $(pwd) $(pwd)/build/px4_sitl_default && \
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(pwd):$(pwd)/Tools/simulation/gazebo-classic/sitl_gazebo-classic && \
roslaunch px4 mavros_posix_sitl.launch'
alias mavros='ros2 launch mavros px4.launch fcu_url:="udp://:14540@127.0.0.1:14557"'
alias qgc='~/QGroundControl-x86_64.AppImage'
alias gcs='~/QGroundControl-x86_64.AppImage'

#alias list='rostopic list'
alias list='ros2 topic list'
alias sensor='ros2 launch px4_ros_com sensor_combined_listener.launch.py'
alias sensor2='ros2 topic echo /fmu/out/sensor_combined'
alias imu='ros2 topic echo -c /mavros/imu/data'
alias pose='ros2 topic echo -c /mavros/local_position/pose'

alias scan='ros2 run ros_gz_bridge parameter_bridge /scan@sensor_msgs/msg/LaserScan@gz.msgs.LaserScan'
alias clock='ros2 run ros_gz_bridge parameter_bridge /clock@rosgraph_msgs/msg/Clock[gz.msgs.Clock'
#alias link='ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 base_link link --ros-args -p use_sim_time:=true'
alias lidar='ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 base_link link'
alias laser='ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 base_link link'
alias link='ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 base_link link'

#alias slam='ros2 launch slam_toolbox online_async_launch.py'
alias slam='ros2 launch ohm_tsd_slam slam.launch.py'

alias matlab='cd ~/MATLAB/R2025b/bin && ./matlab'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source /opt/ros/humble/setup.bash
source ~/ros2_rosgpt/install/setup.bash
source ~/ros2_px4/install/setup.bash
source ~/ros2_mavros/install/setup.bash
source ~/PX4-ROS2-Gazebo-Drone-Simulation-Template/ws_ros2/install/local_setup.bash
source ~/ros2_turtlebot3/install/setup.bash
source ~/ros2_worlds/install/setup.bash
source ~/ros2_slam/install/setup.bash

export TURTLEBOT3_MODEL=burger
export TURTLEBOT4_MODEL=standard
export OPENAI_API_KEY=your_api_key
export GZ_SIM_RESOURCE_PATH=~/.gz/models:~/PX4-Autopilot/Tools/simulation/gz/models
export GAZEBO_MODEL_PATH=~/.gz/models
# export GZ_SIM_RESOURCE_PATH=~/ros2_worlds/src/husarion_gz_worlds/worlds:$GZ_SIM_RESOURCE_PATH
export PATH=$PATH:/opt/xtensa-esp-elf/bin/
export PX4_HOME_LAT=47.397742
export PX4_HOME_LON=8.545593
export PX4_HOME_ALT=488.0

