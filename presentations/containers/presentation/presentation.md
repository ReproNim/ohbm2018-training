name: inverse
layout: true
class: center, middle, inverse
---
# Container based environments

---
name: inverse
layout: true
class: center, middle, inverse
---
## Introduction

---

layout: false

### <span style="color:purple">What are the container technologies</span>


&nbsp;

- #### Isolate the computing environments

&nbsp;

- #### Allow to encapsulate environments in a self-contained unit that can run anywhere

---

### <span style="color:purple">Why do we need containers?</span>

### Science Reproducibility

  - Each project in a lab depends on complex software environments
    - operating system
    - drivers
    - software dependencies: Python/MATLAB/R + libraries
&nbsp;


  - Containers:
    - allow to encapsulate your environment
    - you (and others!) can recreate the environment later in time

---
### <span style="color:purple"> Why do we need containers?</span>

### Collaboration with your colleagues

- Sharing your code or using a repository might not be enough
&nbsp;


- Containers:
  - encapsulate your environment
  - you can easily share the environment


---
### <span style="color:purple"> Why do we need containers?</span>

### Changing hardware

- The personal laptop might not be enough at some point
&nbsp;


- Containers:
  - encapsulate your environment
  - you can easily recreate the environment on a different machine


---

###<span style="color:purple">Why do we need containers?</span>

### Freedom to experiment!
- Universal Install Script from xkcd: *The failures usually don’t hurt anything...*
 And usually all your old programs work...

<img src="img/universal_install_script_2x.png" width="35%" />

- Containers:
  - isolate the environments
  - you can do whatever you want and remove anytime

---
### <span style="color:purple"> Why do we need containers?</span>


### Using existing environments


- Installing all dependencies is not always easy.
&nbsp;


- Containers:
  - isolate and encapsulate the environments
  - there are many ready to use existing environments

---

### <span style="color:purple">What does it mean to work in a container</span>
If you are running a container on your laptop
- it uses the same hardware
- but user spaces and libraries are independent

--

<img src="img/docker1in.jpeg" width="30%" />


<img src="img/docker2in.jpeg" width="50%" />

---
### <span style="color:purple">What does it mean to work in a container</span>

If you are running a container on your laptop
- it uses the same hardware
- but user spaces and libraries are independent
- you can create additional bindings between these two environments

<img src="img/docker3in.jpeg" width="70%" />


---

name: inverse
layout: true
class: center, middle, inverse
---
## Tools
---
layout: false

### <span style="color:purple">Virtual Machines and Containers</span>

- Two main types:

  - Virtual Machines:

      - Virtualbox
      - VMware
      - AWS, Google Compute Engine, ...

  - Containers:

      - Docker
      - Singularity
&nbsp;

--

- Main idea -- isolate the computing environment

  - Allow regenerating computing environments
  - Allow sharing your computing environments

---
### <span style="color:purple">Virtual Machines vs Containers</span>

<img src="img/Containers-vs-Virtual-Machines.jpg" width="80%" />

--

 **Virtual Machines**
  - emulate whole computer system (software+hardware)
  - run on top of a physical machine using a *hypervisor*
  - use *hypervisor* to share and manage hardware of the host, and execute the guest operating system
  - guest machines are completely isolated and have dedicated resources
---
### <span style="color:purple">Virtual Machines vs Containers</span>

  <img src="img/Containers-vs-Virtual-Machines.jpg" width="80%" />



   **Docker containers**
  - share the host system’s kernel with other containers
  - each container gets its own isolated user space
  - only bins and libs are created from scratch
  - **containers are very lightweight and fast to start up**

---
### <span style="color:purple">How  do we choose the technology</span>

There is no one solution that always works, your choice should depend on:
- which hardware is available to you (also do you require GPU)
- where is your data stored
- Docker might me the most portable technology right now, but...
  - if you use HPC centers you will have to use Singularity instead.


---
###<span style="color:purple">Docker and Singularity </span>
- **Docker:**
  - leading software container platform
  - an open-source project
  - it runs now on Mac OS X and Windows Pro (you don't have to install VM!)
  - can escalate privileges - not supported by HPC centers admins

--

- **Singularity:**
  - a container solution created for scientific application
  - supports existing and traditional HPC resources
  - a user inside a Singularity container is the same user as outside the container
(so you can be a root only if you were root on the host system)
  - VM needed on OSX and Windows
  - a Singularity image can be created from a Docker image



