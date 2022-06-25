#sudo docker build . --tag xrf-robot-repo
# sudo docker run -it --env="DISPLAY" --env="QT_X11_NO_MITSHM=1"  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  xrf-robot-repo /bin/bash
# sudo docker run -it --privileged --net=host --env="DISPLAY" --env="QT_X11_NO_MITSHM=1"  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  xrf-robot-repo /bin/bash
# docker ps 

# sudo docker run -it --privileged --net=host --env="DISPLAY" --env="QT_X11_NO_MITSHM=1"  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  xrf-robot-repo-1 /bin/bash


# ./MyAppInstaller_web.install -mode silent -agreeToLicense yes

#http://wiki.ros.org/docker/Tutorials/GUI
# xhost +local:root
# sudo du -h --max-depth=1 /




FROM osrf/ros:melodic-desktop-full  

RUN apt-get update && apt-get install -y --no-install-recommends \
    git apt-utils  python3-catkin-tools unzip nano default-jre\
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"] 

RUN source ./ros_entrypoint.sh &&  git clone https://github.com/RumailM/xrf-robot-stack 

RUN source ./ros_entrypoint.sh && cd xrf-robot-stack && catkin_init_workspace

RUN apt-get update  

ARG DEBIAN_FRONTEND=noninteractive

RUN source ./ros_entrypoint.sh && cd xrf-robot-stack && rosdep install --from-paths src --ignore-src -r -y

RUN source ./ros_entrypoint.sh && cd xrf-robot-stack && catkin build 

RUN cd /xrf-robot-stack/src/matlab_files/for_redistribution && ./MyAppInstaller_web.install -mode silent -agreeToLicense yes


RUN echo "export MCR_PATH=/usr/local/MATLAB/MATLAB_Runtime/v912/"  >> ~/.bashrc
RUN echo "source /xrf-robot-stack/devel/setup.bash" >> ~/.bashrc

RUN touch generate_toolpath.sh
RUN touch simulate.sh
RUN touch replay_toolpath.sh

RUN echo '#!/bin/bash' >> generate_toolpath.sh
RUN echo '#!/bin/bash' >> simulate.sh
RUN echo '#!/bin/bash' >> replay_toolpath.sh

RUN echo "{ sleep 2; roscore; } & { sleep 4; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch; } & { sleep 10; python /xrf-robot-stack/scripts/collisionHandler.py; } & { sleep 14; /xrf-robot-stack/src/matlab_files/for_redistribution_files_only/./run_tool_path_generator.sh /usr/local/MATLAB/MATLAB_Runtime/v912/ 1 0.05 1 10 1 0.11 "/xrf-robot-stack/src/matlab_files/for_redistribution_files_only/pose.mat"; } &" >> /generate_toolpath.sh
RUN echo "{ sleep 2; roscore; } & { sleep 4; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch; } & { sleep 10; python /xrf-robot-stack/scripts/collisionHandler.py; } & " >> /simulate.sh
RUN echo "{ sleep 2; roscore; } & { sleep 4; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch; } & { sleep 10; python /xrf-robot-stack/scripts/collisionHandler.py; } & { sleep 14; /xrf-robot-stack/src/matlab_files/for_redistribution_files_only/./run_tool_path_replay.sh /usr/local/MATLAB/MATLAB_Runtime/v912/  "/xrf-robot-stack/src/matlab_files/for_redistribution_files_only/filtered.mat"; } &" >> /replay_toolpath.sh

# { sleep 2; roscore; } & { sleep 4; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch; } & { sleep 10; python /xrf-robot-stack/scripts/collisionHandler.py; } & { sleep 14; /xrf-robot-stack/src/matlab_files/for_redistribution_files_only/./run_fcomp.sh $MCR_PATH 1 0.05 1 10 1 0.11 "pose.mat"; } &

# { sleep 2; roscore; } & { sleep 4; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch; } & { sleep 10; python /xrf-robot-stack/scripts/collisionHandler.py; } & 



# source /xrf-robot-stack/devel/setup.bash && roscore & python /xrf-robot-stack/devel/collisionHandler.py & roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
# # RUN echo "MATLAB_RUNTIME_INSTALL_DIR=/usr/local/MATLAB/MATLAB_Runtime/v912" >> ros_entrypoint.sh

# RUN echo "LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/MATLAB/MATLAB_Runtime/v912/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/extern/bin/glnxa64"" >> ros_entrypoint.sh

# RUN echo "export LD_LIBRARY_PATH" >> ros_entrypoint.sh



# RUN apt-get update && apt-get install -y --no-install-recommends \
#     python3-rospkg\
#     && rm -rf /var/lib/apt/lists/*

# RUN python -m pip install rospkg

# RUN echo "hostname -I" > ros_entrypoint.sh



# RUN source ./ros_entrypoint.sh && mkdir xrf-robot-stack-ws && cd xrf-robot-stack-ws  && mkdir src\ 
# && catkin_init_workspace \
# && git clone https://github.com/RumailM/xrf-robot-stack src/xrf-robot-stack \
# && rosdep install --from-paths src --ignore-src -r -y \ 
# && catkin build 

# /opt/ros/melodic/lib:/usr/local/MATLAB/MATLAB_Runtime/v912/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/extern/bin/glnxa64
# /opt/ros/melodic/lib:/usr/local/MATLAB/MATLAB_Runtime/v912/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v912/extern/bin/glnxa64
