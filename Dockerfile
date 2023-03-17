FROM osrf/ros:melodic-desktop-full

# user tools
ENV SHELL /bin/bash

RUN apt update && apt install -y \
    screen \
    vim \
    git

# refer: https://github.com/AutonomyLab/create_robot
# install roomba ros driver
RUN apt update && apt install -y \
    python-rosdep \
    python-catkin-tools

RUN mkdir -p /root/ros_ws/src && \
    cd /root/ros_ws/ && \
    catkin init

RUN cd ~/ros_ws/src && \
    git clone https://github.com/AutonomyLab/create_autonomy.git

RUN cd /root/ros_ws && \
    rosdep update && \
    yes | rosdep install --from-paths src -i

# setting path and catkin build
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    echo "source /root/ros_ws/devel/setup.bash" >> ~/.bashrc && \
    cd /root/ros_ws && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash;catkin build"