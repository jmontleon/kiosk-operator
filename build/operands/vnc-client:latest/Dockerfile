FROM fedora:31

RUN dnf -y update && \ 
    dnf -y install git \
                   hostname \
                   net-tools \
                   procps-ng \
                   python3-pip \
                   which \
    && dnf clean all
RUN pip3 install websockify
RUN git clone https://github.com/novnc/novnc
RUN ln -sf /novnc/vnc.html /novnc/index.html
ENTRYPOINT /novnc/utils/launch.sh --vnc localhost:5901
