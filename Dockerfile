FROM ubuntu:16.04

workdir /usr/src/app

run apt-get clean && apt-get update
run apt-get -y install wget unzip

workdir /usr/local/
run wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.11/opencv-2.4.11.zip
run unzip opencv-2.4.11.zip
run rm /usr/local/opencv-2.4.11.zip

run apt-get install -y build-essential
run apt-get install -y git
run apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
run apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev
run apt-get install -y libjasper-dev libdc1394-22-dev

run apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev
run apt-get -qq install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev
run apt-get -qq install libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev
run apt-get -qq install libgtk2.0-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev
run apt-get -qq install libvorbis-dev libxvidcore-dev x264 v4l-utils

run apt-get -y install beanstalkd vim python-pip python-dev build-essential libxml2 apt-utils
run apt-get -y install libtesseract-dev liblog4cplus-dev libleptonica-dev libcurl3-dev ffmpeg=7:2.8.11-0ubuntu0.16.04.1

workdir /usr/local/opencv-2.4.11
run mkdir release
workdir /usr/local/opencv-2.4.11/release

# compile and install
run cmake -G "Unix Makefiles" -D CMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D BUILD_FAT_JAVA_LIB=ON -D INSTALL_TO_MANGLED_PATHS=ON -D INSTALL_CREATE_DISTRIB=ON -D INSTALL_TESTS=ON -D ENABLE_FAST_MATH=ON -D WITH_IMAGEIO=ON -D BUILD_SHARED_LIBS=OFF -D WITH_GSTREAMER=ON ..
run make all -j4
run make install
run ln -s /usr/local/opencv-2.4.11/release/lib/cv2.so /usr/local/lib/python2.7/dist-packages/cv2.so
